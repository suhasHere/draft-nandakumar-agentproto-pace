---
title: "PACE: Protocol for Agent Communication Exchange"
abbrev: "PACE over MOQT"
category: std

docname: draft-nandakumar-ai-agent-moq-transport-latest
submissiontype: IETF
number:
date: 2026-06-28
consensus: true
v: 3
area: "Applications and Real-Time"
workgroup: "Agent Communication Protocols"
keyword:
 - agent-to-agent
 - agent-to-tool
 - MOQT
 - AI agents
 - session protocol
 - real-time communication

venue:
  group: "Agent Communication Protocols"
  type: "Working Group"
  mail: "agent2agent@ietf.org"
  arch: "https://mailarchive.ietf.org/arch/browse/agent2agent/"
  github: "suhasHere/draft-a2a-moqt-transport"
  latest: "https://suhasHere.github.io/draft-a2a-moqt-transport/draft-nandakumar-ai-agent-moq-transport.html"

author:
 -
    name: "Suhas Nandakumar"
    organization: "Cisco"
    email: "snandaku@cisco.com"
 -
    name: "Cullen Jennings"
    organization: "Cisco Systems"
    email: "fluffy@cisco.com"

normative:
  RFC2119:
  RFC8126:
  RFC8174:
  RFC9000:
  RFC8446:
  MoQ-TRANSPORT:
    title: "Media over QUIC Transport"
    date: 2026-01
    author:
    - ins: L. Curley
    - ins: K. Pugin
    - ins: S. Nandakumar
    - ins: V. Vasiliev
    - ins: I. Swett
    seriesinfo:
      Internet-Draft: draft-ietf-moq-transport-16
    target: https://datatracker.ietf.org/doc/draft-ietf-moq-transport/

informative:
  RFC7519:
  RFC7540:
  RFC9110:
  RFC9297:
  A2A:
    title: "Agent-to-Agent Protocol Specification"
    date: 2025
    author:
    - org: A2A Project
    seriesinfo:
      Version: 0.3.0
    target: https://google.github.io/A2A/specification/
  MCP:
    title: "Model Context Protocol Specification"
    date: 2025-06
    author:
    - org: Anthropic
    seriesinfo:
      Version: 2025-06-18
    target: https://modelcontextprotocol.io/specification/
  AutoGen:
    title: "AutoGen: Enabling Next-Gen LLM Applications via Multi-Agent Conversation"
    date: 2023
    author:
    - ins: Q. Wu
    - ins: G. Banber
    - ins: Y. Zhang
    - ins: Y. Wu
    - ins: B. Li
    - ins: E. Zhu
    - ins: A. Awadallah
    seriesinfo:
      arXiv: "2308.08155"
    target: https://arxiv.org/abs/2308.08155
  MoQ-C4M:
    title: "Common Access Token for Media over QUIC"
    date: 2025
    author:
    - ins: S. Jennings
    seriesinfo:
      Internet-Draft: draft-ietf-moq-c4m
    target: https://datatracker.ietf.org/doc/draft-ietf-moq-c4m/
  MCP-MOQT:
    title: "Model Context Protocol and Agent Skills over Media over QUIC Transport"
    date: 2025
    author:
    - ins: C. Jennings
    - ins: I. Swett
    - ins: J. Rosenberg
    - ins: S. Nandakumar
    seriesinfo:
      Internet-Draft: draft-mcp-over-moqt
    target: https://datatracker.ietf.org/doc/draft-mcp-over-moqt/
  SD-AGENT:
    title: "SD Agent: Selective Disclosure for Agent Discovery and Identity Management"
    date: 2026-02
    author:
    - ins: S. Nandakumar
    - ins: C. Jennings
    seriesinfo:
      Internet-Draft: draft-nandakumar-agent-sd-jwt-02
    target: https://datatracker.ietf.org/doc/draft-nandakumar-agent-sd-jwt/

--- abstract

This document defines the Protocol for Agent Communication Exchange (PACE),
a session protocol for AI agent communication over Media over QUIC Transport
(MOQT). PACE provides session lifecycle management, multi-modal data
exchange, agent identity verification, and delegated authorization within
MOQT's publish/subscribe model, supporting point-to-point and
point-to-multipoint topologies through relay infrastructure.

--- middle

# Introduction

AI agents are autonomous software systems that interact with other agents
and tools to complete tasks. As agent communication expands across the
Internet, it requires: verifiable agent identity independent of users,
capability discovery and collaboration across network boundaries,
multi-modal data exchange (text, audio, video) with session management,
and delegated authorization across agent chains.

This document defines the Protocol for Agent Communication Exchange (PACE),
a session layer over Media over QUIC Transport (MOQT) {{MoQ-TRANSPORT}}.
PACE enables diverse agent protocols to leverage MOQT's publish/subscribe
model, relay-based fan-out, built-in prioritization, and efficient
multiplexing over QUIC.

## Design Goals

1. **Session Lifecycle**: Timed sessions with establishment, update,
   suspension, and termination.
2. **Multi-Modal**: Concurrent real-time media, chat, and operations.
3. **Scalable**: Relay-based fan-out with failure recovery.
4. **Flexible Topologies**: Point-to-point and point-to-multipoint.
5. **Agent Identity**: Authentication independent of user identity with
   delegated authorization.
6. **Protocol Agnostic**: Usable by A2A, MCP, and custom protocols.

## Requirements Language

{::boilerplate bcp14-tagged}

# Architecture Overview

The PACE architecture layers as follows:

~~~
┌─────────────────────────────────────────────────────────┐
│  Application Protocols (A2A, MCP, AutoGen, Custom)      │
├─────────────────────────────────────────────────────────┤
│  PACE: Sessions │ Identity │ Auth │ Multi-Modal │ QoS   │
├─────────────────────────────────────────────────────────┤
│  MOQT: Pub/Sub │ Namespace Routing │ Relay Caching      │
├─────────────────────────────────────────────────────────┤
│  QUIC / WebTransport: TLS 1.3 │ Mux │ Migration         │
└─────────────────────────────────────────────────────────┘
~~~
{: #figure-arch title="PACE Architecture"}

## MOQT as Session Substrate

Media over QUIC Transport (MOQT) {{MoQ-TRANSPORT}} is a publish/subscribe
protocol over QUIC providing:

* **Hierarchical Namespaces**: Content addressed by namespace tuples,
  enabling prefix-based routing and caching
* **Relay Fan-Out**: Publishers connect once; relays distribute to all
  subscribers without direct peer connections
* **Low Latency**: QUIC 0-RTT, stream multiplexing, priority (0-255)
* **Fault Tolerance**: Relay caching enables recovery from disconnections

Agents connect to MOQT relays which handle subscription matching,
fan-out, and object caching. Relays MAY be organized hierarchically
for geographic locality.

# Namespace Organization {#namespace}

PACE uses MOQT's hierarchical namespace for routing, isolation, and
multiplexing. MOQT addresses content using a namespace tuple (an ordered
sequence of string fields) combined with a track name. PACE organizes
all communication into three namespace scopes defined in the following
subsections.

## Agent Namespace

~~~
  ("pace", "agents", {agent-id}) -- {track}
~~~

This is an agent's persistent identity on the relay network. Each agent
publishes the following tracks:

* `"card"` — Agent Card containing capabilities, identity claims,
  authentication schemes, and MOQT connectivity information
* `"inbox"` — Incoming session invitations from other agents; each
  object contains a session-id and the inviting agent's identifier

The common prefix `("pace", "agents")` enables SUBSCRIBE_NAMESPACE-based
discovery of all agents on the network. See {{agent-discovery}} for the
complete discovery flow.

## Session Communication Namespace

~~~
  ("pace", "agents", {agent-id}, {session-id}) -- {track}
~~~

A session-id is a shared UUID representing a collaboration context — it
is not scoped to or owned by any single agent. Any agent can generate a
session-id and invite others to collaborate under it. When multiple
agents participate in a session, they each publish tracks under their
own agent namespace using the same session-id.


Each agent in a session publishes the following tracks:

* `"ctrl"` — Session lifecycle messages (SESSION_INIT, SESSION_ACCEPT,
  SESSION_UPDATE, SESSION_CLOSE)
* `"chat"` — Chat messages and streaming LLM output
* `"audio"` — Real-time audio stream
* `"video"` — Real-time video stream
* `"ops/{req-id}"` — Request/response operations (one track per request)

Protocol bindings add prefix-scoped tracks to enable multiple protocols
to operate concurrently within a single session without track name
collisions:

* `"a2a/{category}/{id}"` — A2A protocol operations, where `{category}`
  is the operation type (e.g., `request`, `response`, `task`, `stream`)
  and `{id}` is the request or task identifier
* `"mcp/{category}/{id}"` — MCP protocol operations, where `{category}`
  is the primitive type (e.g., `tools`, `resources`, `prompts`) and
  `{id}` is the tool name or resource URI
* `"ext/{proto}/{category}/{id}"` — Custom protocol extensions, where
  `{proto}` identifies the protocol

For example, the MCP over MOQT specification {{MCP-MOQT}} defines
tracks like `(mcp, {session-id}, tools) -- ({tool-name})`; within PACE,
this maps to track name `"mcp/tools/{tool-name}"` under the agent's
session namespace, preserving the MCP semantics while coexisting with
A2A or other protocol tracks in the same session.

See {{example-workflows}} for concrete examples of agent-to-agent,
agent-to-tool, and multi-agent collaboration workflows.

## Session Discovery Namespace

~~~
  ("pace", "discovery", "sessions", {agent-id}) -- {session-id}
~~~

Agents advertise their active sessions on this top-level discovery
namespace so that other agents can find sessions to join. Each agent
publishes one track per active session (the track name is the
session-id). Each object on a session track contains:

* `session-id` — The shared session UUID
* `description` — Human-readable purpose of the session
* `participants` — List of agent-ids currently in the session
* `modalities` — Supported data modalities (text, audio, video, etc.)

Agents discover active sessions by issuing SUBSCRIBE_NAMESPACE on
`("pace", "discovery", "sessions")`.


# Session Management {#session-management}

A PACE session represents a logical communication context between two or
more agents. Sessions provide lifetime management, context preservation,
and failure recovery. All session operations use the namespace structure
defined in {{namespace}}.

## Session Lifecycle

Sessions progress through defined states:

~~~
IDLE ──establish──▶ PENDING ──accept──▶ ACTIVE ◀──update──┐
  ◀──reject──────────┘                    │  │             │
                                     suspend  terminate    │
                                          ▼       │       │
                                    SUSPENDED     ▼       │
                                     │  │       CLOSED ◀──┘
                                     │  └resume──▶ ACTIVE
                                     └─timeout──▶ CLOSED
~~~
{: #figure-session-states title="Session State Machine"}

IDLE:
: No session exists. Agent is available to initiate or accept sessions.

PENDING:
: Establishment in progress (negotiation, authentication).

ACTIVE:
: Session established; data exchange occurring. May be updated.

SUSPENDED:
: Temporarily inactive, state preserved. Transitions to CLOSED on timeout.

CLOSED:
: Session terminated. Resources released.

## Session Establishment

Session establishment creates a shared communication context between
two or more agents. Its goals are: (1) negotiate capabilities and
modalities both agents support, (2) exchange identity tokens and verify
authorization, and (3) set up the MOQT namespace subscriptions so that
both agents can publish and receive messages within the session.

The mechanism relies on three MOQT operations. The initiator publishes
a SESSION_INIT object on a new session control track under its own
namespace, containing proposed session parameters. It then delivers a
lightweight invite to the target agent's inbox track, notifying the
target that a session is waiting. The target agent inspects the invite,
subscribes to the initiator's session namespace to read the SESSION_INIT
parameters, and — if it accepts — publishes a SESSION_ACCEPT on its own
session control track. The initiator then subscribes to the target's
session namespace, completing the bidirectional subscription setup.

Once both agents have subscribed to each other's session namespace, the
session transitions to ACTIVE and data exchange can begin on any track
within that session scope.

The following example illustrates the flow for Agent A initiating a
session with Agent B (assumes A has already discovered B via
{{agent-discovery}}):

~~~
Session Establishment Example:

Agent A                          MOQT Relay                        Agent B
  │                                  │                                │
  │── PUBLISH SESSION_INIT ─────────▶│                                │
  │   Track: ("pace","agents",       │                                │
  │    "agent-a",{sid}) -- "ctrl"    │                                │
  │   Object: {session params,       │                                │
  │    capabilities, modalities}     │                                │
  │                                  │                                │
  │── PUBLISH invite ───────────────▶│── forward to B's inbox ───────▶│
  │   Track: ("pace","agents",       │                                │
  │    "agent-b") -- "inbox"         │                                │
  │   Object: {session-id,           │                                │
  │    from: agent-a}                │                                │
  │                                  │                                │
  │── PUBLISH session advertisement ▶│                                │
  │   Track: ("pace","discovery",    │                                │
  │    "sessions","agent-a")         │                                │
  │    -- {sid}                      │                                │
  │                                  │                                │
  │                                  │   [B receives invite, reads    │
  │                                  │    SESSION_INIT, decides to    │
  │                                  │    accept]                     │
  │                                  │                                │
  │                                  │◀── SUBSCRIBE_NAMESPACE ────────│
  │                                  │   ("pace","agents","agent-a",  │
  │                                  │    {sid})                      │
  │                                  │                                │
  │                                  │◀── PUBLISH SESSION_ACCEPT ─────│
  │◀── forward ─────────────────────│   Track: ("pace","agents",     │
  │                                  │    "agent-b",{sid}) -- "ctrl"  │
  │                                  │   Object: {capabilities,      │
  │                                  │    accepted modalities}        │
  │                                  │                                │
  │── SUBSCRIBE_NAMESPACE ──────────▶│                                │
  │   ("pace","agents","agent-b",    │                                │
  │    {sid})                        │                                │
  │                                  │                                │
  │◀═══════════ PACE Session ACTIVE ═══════════════════════════════▶│
~~~
{: #figure-session-establish title="Session Establishment Example"}

### Session Parameters

The SESSION_INIT object contains:

* `session-id`: Globally unique session identifier (UUID)
* `session-type`: Short-lived (bounded duration) or long-lived (indefinite)
* `session-timeout`: Maximum idle duration before automatic termination
* `max-participants`: Maximum number of agents in the session
* `supported-modalities`: Bitmask of data modalities the agent can handle
* `identity-token`: Agent identity token (see {{identity-discovery}})
* `supported-protocols`: Application protocols offered (A2A, MCP, etc.)

### MOQT Setup Extensions

PACE defines the following MOQT setup parameters negotiated during
CLIENT_SETUP/SERVER_SETUP:

| Parameter | ID | Description |
|-----------|-----|-------------|
| pace-version | 0x50414301 | PACE protocol version |
| agent-identity | 0x50414302 | Agent identity token or certificate reference |
| supported-protocols | 0x50414303 | Bitmask of application protocols (A2A=0x01, MCP=0x02) |
| auth-schemes | 0x50414304 | Supported authentication schemes |
| session-capabilities | 0x50414305 | Session capability flags |

## Timed Sessions

Sessions are either short-lived (bounded duration, auto-terminates on
completion or timeout) or long-lived (indefinite, survives idle periods
via SUSPENDED state). The `session-timeout` parameter defines the
maximum idle period before automatic transition to CLOSED.

## Session Update

Active sessions can be updated by publishing a SESSION_UPDATE message
on the control track. Updates can modify modalities, participants,
authorization scopes, or timeout. All participants MUST acknowledge
the update before new parameters take effect.

## Session Recovery {#session-recovery}

PACE provides graceful recovery from network and server failures:

QUIC Connection Migration:
: Sessions survive network path changes (e.g., WiFi to cellular)
  via QUIC's connection ID mechanism without re-establishing the
  MOQT session.

Relay Caching:
: Relays cache recent objects, allowing reconnecting agents to receive
  missed messages without requiring peer retransmission.

Session Resumption:
: Agents resume SUSPENDED sessions by reconnecting to the relay,
  re-issuing PUBLISH_NAMESPACE on their agent namespace, and
  re-subscribing to peer session namespaces. The relay delivers
  cached objects from the point of disconnection.

State Checkpointing:
: Agents SHOULD periodically publish state checkpoints on a dedicated
  track, enabling recovery after relay failures.

## Session Termination

Sessions terminate explicitly via SESSION_CLOSE on the control track or
implicitly via timeout. Upon termination, all subscriptions are
cancelled, pending operations receive cancellation notifications, and
session resources are released after a configurable grace period.

# Agent Identity and Discovery {#identity-discovery}

## Agent Identity Model

PACE authenticates agents independently of the users they represent.
This enables independent revocation, capability-scoped permissions,
audit trails for agent actions, and delegation chains.

### Agent Identity Token

Each agent presents an identity token during session establishment.
The token format is based on JWT {{RFC7519}} with agent-specific claims:

| Claim | Description |
|-------|-------------|
| `agent-id` | Globally unique agent identifier (UUID) |
| `issuer` | Identity provider that issued the token |
| `subject` | User or organization the agent serves |
| `capabilities` | Agent capability descriptors |
| `scopes` | Authorized operation scopes |
| `issued-at` | Token issuance timestamp |
| `expires-at` | Token expiration timestamp |
| `delegation-chain` | Parent agent references (see below) |

The token is cryptographically signed by the issuing authority.
Agents MAY use the SD-JWT based identity mechanism defined in
{{SD-AGENT}} to support selective disclosure of identity attributes
during session establishment.

### Delegation Chains

When an agent acts on behalf of another agent, the identity token
includes a `delegation-chain` field tracing the authorization path
(e.g., User → Coordinator → Researcher → Tool). Each entry records
the granting agent and the scope granted. Receiving agents verify
the complete chain to ensure each link has appropriate authorization.

## Agent Discovery {#agent-discovery}

Agents discover each other using MOQT's PUBLISH_NAMESPACE and
SUBSCRIBE_NAMESPACE operations before establishing any PACE session.
Discovery operates on the Agent Namespace scope defined in {{namespace}}.
Each agent is identified by a globally unique agent-id (UUID),
verifiable via the Agent Card (see {{agent-card}}).

### Part 1: Discovering Agent Namespaces

Agents announce their presence by issuing PUBLISH_NAMESPACE on their
namespace `("pace","agents",{agent-id})`. Other agents discover
available peers by issuing SUBSCRIBE_NAMESPACE on the common prefix
`("pace","agents")`. The relay forwards namespace announcements to
matching subscribers, enabling Agent B to learn Agent A's namespace
prefix without prior knowledge.

If an agent-id is known out-of-band (e.g., from a registry or URL),
agents MAY skip Part 1 and proceed directly to Part 2.

### Part 2: Fetching Agent Card and Inbox

Once Agent B knows Agent A's namespace prefix, it issues
SUBSCRIBE_NAMESPACE on `("pace","agents",{agent-a})` to discover A's
tracks ("card", "inbox"). Agent B then subscribes to the "card" track
to fetch A's Agent Card (capabilities, identity, authentication) and
learns the "inbox" track where session invitations can be delivered.

### Agent Card {#agent-card}

Each agent publishes an Agent Card on track `"card"` under its namespace
`("pace","agents",{agent-id})`. When capabilities change, the agent
publishes a new object (incrementing the group). Receivers SHOULD verify
the card's signature and expiration before acting on its claims.

All Agent Cards MUST include:

* Agent identifier (UUID) and display name
* Supported modalities and protocols
* Authentication schemes
* Identity claims (issuer, public key, expiration)

The card format is protocol-specific. For A2A agents, see
{{a2a-agent-card}}. Agent Cards MAY use selective disclosure
{{SD-AGENT}} to reveal only claims necessary for a given interaction.

### Inbox Track {#inbox-track}

Each agent subscribes to its own inbox track
`("pace","agents",{agent-id}) -- "inbox"` upon connecting to the relay.
Other agents publish session invitations to this track. Each inbox
object contains a session-id and the initiator's agent-id. Late-joining
agents receive cached inbox messages from the relay.

# Multi-Modal Data Exchange {#data-exchange}

PACE supports concurrent exchange of multiple data modalities within a
single session, each with appropriate quality of service.

## Modality Types

PACE defines the following data modality classes:

| Modality | Latency | Examples | Delivery |
|----------|---------|----------|----------|
| Real-time | < 100ms | Voice, video, screen share | Continuous stream |
| Semi-real-time | < 1s | Chat messages, streaming LLM output | Ordered objects |
| Non-real-time | Best effort | Tool calls, file transfers, context | Reliable delivery |

## Channel Architecture

Each modality maps to dedicated MOQT tracks within the Session
Communication Namespace ({{namespace}}). Different modalities are
isolated by track name while sharing session context and authorization.

## Priority and Quality of Service

MOQT's 0-255 priority scale enables differentiated treatment of messages
based on urgency and modality. PACE defines the following priority tiers:

| Priority Range | Category | Use |
|----------------|----------|-----|
| 0-15 | Critical Control | Session termination, emergency cancel |
| 16-31 | Urgent Control | Error notifications, auth revocation |
| 32-63 | Real-time Media | Voice/video frames |
| 64-95 | Interactive | Chat messages, streaming LLM tokens |
| 96-127 | Standard Operations | Tool calls, request/response |
| 128-159 | Discovery | Capability cards, agent advertisements |
| 160-191 | Background | Telemetry, non-critical notifications |
| 192-255 | Bulk Transfer | File transfers, context exchange |

### Group Order

MOQT Group Order controls delivery sequencing within a track:

* Real-time media: Descending order (newest first, drop stale frames)
* Chat/streaming text: Ascending order (preserve message sequence)
* Operations: Ascending order (preserve execution order)
* Bulk transfers: Ascending order (sequential chunk delivery)

## Request/Response Pattern {#request-response}

Request/response interactions use coordinated publish operations.
Agent A publishes a request object on its own track
`("pace","agents","agent-a",{sid}) -- "ops/{req-id}"`. Agent B, which
has subscribed to A's session namespace, receives the request, processes
it, and publishes the response on its own corresponding track
`("pace","agents","agent-b",{sid}) -- "ops/{req-id}"`. Agent A receives
the response through its subscription to B's session namespace.

## Streaming Pattern {#streaming}

Long-running operations produce incremental results as MOQT objects
organized into groups representing execution phases. The server advances
to a new group at each phase transition (e.g., initialization, progress,
completion). Multiple objects within a group represent incremental data
for that phase.

Late-joining subscribers receive the latest complete group from relay
cache, enabling mid-operation catch-up without replaying the full
history.

## Real-Time Media Exchange

Audio and video streams use dedicated tracks (`"audio"`, `"video"`)
with descending group order (newest-first) and high priority (32-63),
ensuring media frames preempt lower-priority data under congestion.

# Communication Topologies {#topologies}

PACE supports multiple communication topologies through MOQT's relay
fan-out:

Point-to-Point:
: Two agents publish and subscribe to each other's session tracks.
  Used for tool invocation, task delegation, and bilateral collaboration.

Point-to-Multipoint (Fan-Out):
: One agent publishes; multiple agents subscribe. The relay handles
  fan-out without the publisher maintaining per-subscriber state.
  Used for broadcast notifications and shared context distribution.

Multi-Party:
: All participants publish on their own tracks and subscribe to
  each other's tracks within the same session-id. Adding a
  participant requires publishing SESSION_JOIN on the control track;
  existing participants receive the notification and subscribe to
  the new agent's session namespace.

Hierarchical Teams:
: A coordinator creates child PACE sessions to delegate subtasks.
  Each level operates as a separate session with narrowed authorization
  scope. Delegation chains ({{identity-discovery}}) maintain an
  auditable path from the original user authorization.

# Authorization and Security {#authorization}

## Authorization Model

PACE implements a behavior-driven authorization model where access
tokens are scoped to specific operations an agent is permitted to
perform.

### Behavior-Driven Scopes

Scopes are structured as `{domain}:{resource}:{action}:{constraints}`,
bound to specific agent behaviors rather than roles. Constraints
support dynamic limits (time bounds, resource limits, counts).

### Delegated Authorization

When agents invoke other agents, each delegation narrows the scope.
Agent A (holding scope S) requests a sub-scope S' ⊂ S for Agent B.
Agent B can further narrow to S'' ⊂ S' for downstream tools.
Downstream agents cannot exceed their delegator's permissions.

Authorization tokens are presented in SESSION_INIT and validated
including the full delegation chain. Tokens are refreshed proactively
before expiration.

### Confirmation and Evidence

For high-risk operations, PACE supports confirmation requirements
where agents must present cryptographic evidence of approval (human,
policy-check, or MFA) before the operation proceeds.

## Transport Security

All PACE communication is encrypted via TLS 1.3 (QUIC requirement).
Agent identity tokens are cryptographically signed with short expiry.
MOQT Common Access Tokens {{MoQ-C4M}} provide relay-level namespace
authorization. Relay nodes cannot access payload content unless
explicitly authorized as trusted intermediaries.

## Privacy Considerations

Agents SHOULD minimize shared data to what is necessary for the task.
Long-lived sessions SHOULD support forward secrecy through periodic
key rotation. Relay operators MUST NOT retain content beyond
operational necessity.

# MOQT Transport Binding Layer {#transport-binding}

This section defines how PACE maps to MOQT primitives: connection
setup, namespace operations, message serialization, and operation
mappings. All namespace and track references follow the structure
defined in {{namespace}}.

## Connection Establishment {#connection-establishment}

Agents MUST establish either a native QUIC connection or a WebTransport
{{RFC9297}} session as defined in {{MoQ-TRANSPORT}}. For native QUIC
connections, agents MUST use the ALPN value "moqt". For WebTransport,
the protocol is negotiated using the "WT-Available-Protocols" mechanism
as specified in {{MoQ-TRANSPORT}}.

Upon establishing the MOQT session (CLIENT_SETUP / SERVER_SETUP), an
agent performs the bootstrap sequence to make itself discoverable and
ready to receive session invitations. This sequence is:

1. **Announce**: PUBLISH_NAMESPACE on `("pace", "agents", {agent-id})`
2. **Publish Agent Card**: Publish on track `"card"` under its namespace
3. **Subscribe to inbox**: Subscribe to its own `"inbox"` track

See {{agent-discovery}} for the full discovery flow that follows
bootstrap.

## Track Organization {#track-organization}

Each agent publishes exclusively on its own tracks. Other agents
subscribe to tracks they are interested in. The relay handles fan-out
to all subscribers. This per-agent publishing model ensures clear
ownership and enables relay caching.

Namespace structure and track names are defined in {{namespace}}.
Participants discover each other's session tracks using
SUBSCRIBE_NAMESPACE on `("pace", "agents", {peer-agent-id}, {sid})`.

## Message Serialization {#message-serialization}

Protocol messages are encapsulated within MOQT objects using a PACE
envelope prepended to the payload:

| Field | Size | Description |
|-------|------|-------------|
| `version` | 1 byte | PACE envelope version (currently 0x01) |
| `flags` | 1 byte | 0x01=compressed, 0x02=fragmented, 0x04=encrypted |
| `length` | varint | Length of the serialized protocol message |
| payload | variable | Serialized protocol message |

Bindings SHOULD preserve native message formats. For example, A2A
messages retain their JSON-RPC 2.0 format; the PACE envelope wraps
the serialized JSON bytes.

## Operation-to-Primitive Mapping {#operation-mapping}

Mapping of PACE operations to MOQT primitives:

| Operation | MOQT Mechanism | Namespace / Track |
|-----------|----------------|-------------------|
| Agent discovery | PUBLISH_NS + SUBSCRIBE_NS | `("pace","agents")` prefix |
| Fetch Agent Card | SUBSCRIBE + OBJECT | `("pace","agents",{id}) -- "card"` |
| Session discovery | SUBSCRIBE_NS | `("pace","discovery","sessions")` prefix |
| Session invite | PUBLISH to inbox | `("pace","agents",{id}) -- "inbox"` |
| Join session | SUBSCRIBE_NS on peer | `("pace","agents",{peer},{sid})` |
| One-shot request | PUBLISH + OBJECT | `("pace","agents",{id},{sid}) -- "ops/{req-id}"` |
| Streaming | PUBLISH + multiple OBJECTs | `-- "a2a/stream/{id}"` (groups) |
| Cancellation | OBJECT on ctrl | `-- "ctrl"` |
| Subscription | SUBSCRIBE (ongoing) | `-- "a2a/task/{id}"` |
| Broadcast | PUBLISH + relay fan-out | Any track (relay fans out) |

# Protocol Bindings {#protocol-bindings}

This section defines protocol bindings that map application protocol
semantics to MOQT. Each binding operates within PACE sessions, using
the Session Communication Namespace ({{namespace}}) and channel
architecture ({{data-exchange}}).

## Binding Architecture

Protocol bindings sit between application protocols and the PACE session
layer. Each binding defines:

* **Protocol Identifier**: Unique string used as the track name prefix
* **Namespace Pattern**: How operations map to track names
* **Message Serialization**: Encoding within MOQT object payloads
* **Operation Mapping**: Protocol operations to MOQT primitives
* **Priority Mapping**: Message types to PACE priority tiers

Protocols use distinct track name prefixes within PACE sessions:

| Protocol | Track Prefix | Example Full Path |
|----------|--------------|-------------------|
| A2A | `a2a/` | `("pace","agents","agent-a","s1") -- "a2a/task/t1"` |
| MCP | `mcp/` | `("pace","agents","fs-server","s1") -- "mcp/tools/read"` |
| AutoGen | `autogen/` | `("pace","agents","rt1","s1") -- "autogen/message/conv1"` |
| Generic | `ext/{proto}/` | `("pace","agents","agent-a","s1") -- "ext/myproto/rpc/call"` |

## A2A Binding {#a2a-binding}

The Agent-to-Agent Protocol {{A2A}} binding maps A2A task delegation
and collaboration to MOQT primitives using the `a2a/` category prefix.

### Namespace Structure

A2A operates within a PACE session. Each agent publishes A2A messages
on tracks under its own session namespace:

~~~
Namespace: ("pace", "agents", {agent-id}, {session-id})
Tracks:    "a2a/{subcategory}/{identifier}"
~~~

A2A track name patterns:

| Track Pattern | Purpose |
|---------------|---------|
| `a2a/request/{request-id}` | Outbound requests |
| `a2a/response/{request-id}` | Request responses |
| `a2a/stream/{request-id}` | Streaming operations |
| `a2a/task/{task-id}` | Task lifecycle |
| `a2a/notify/{type}` | Push notifications |

### A2A Operation Mapping {#a2a-operation-mapping}

The following table maps A2A v0.3.0 operations to MOQT primitives:

| A2A Operation | MOQT Mechanism | Track Name |
|---------------|----------------|------------|
| `SendMessage` | PUBLISH + OBJECT | `a2a/request/{req-id}` |
| `SendStreamingMessage` | PUBLISH + multiple OBJECTs | `a2a/stream/{req-id}` |
| `GetTask` | SUBSCRIBE + OBJECT | `a2a/task/{task-id}` |
| `ListTasks` | SUBSCRIBE_NAMESPACE | (discover `a2a/task/*` tracks) |
| `CancelTask` | OBJECT on ctrl track | `ctrl` |
| `SubscribeToTask` | SUBSCRIBE (ongoing) | `a2a/task/{task-id}` |
| `GetExtendedAgentCard` | SUBSCRIBE + OBJECT | Agent's `card` track |
| `SetPushNotificationConfig` | PUBLISH + OBJECT | `a2a/notify/config` |
| `GetPushNotificationConfig` | SUBSCRIBE + OBJECT | `a2a/notify/config` |

### Message Format

A2A messages are serialized as JSON-RPC 2.0 within MOQT objects,
preserving A2A's native format. The PACE envelope wraps the JSON bytes:

~~~json
{
  "jsonrpc": "2.0",
  "method": "message/send",
  "params": {
    "message": {
      "role": "user",
      "parts": [{"kind": "text", "text": "Hello agent"}]
    }
  },
  "id": "req-001"
}
~~~

### Priority Mapping

| A2A Message Type | MOQT Priority Range | Description |
|------------------|---------------------|-------------|
| Cancel/Error | 0-31 | Task cancellation, critical errors |
| SendMessage response | 32-63 | Responses requiring immediate delivery |
| SendMessage request | 64-95 | Normal request messages |
| Task status updates | 96-127 | Incremental task state changes |
| Streaming artifacts | 96-127 | Streaming result data |
| Discovery (Agent Card) | 128-159 | Agent card exchange |
| Push notifications | 160-191 | Asynchronous notifications |
| Background/bulk | 192-255 | Large file transfers, batch ops |

### Streaming Support

A2A streaming operations (SendStreamingMessage, task subscriptions) use
the streaming pattern defined in {{streaming}}. A2A streaming events map
to MOQT objects as follows:

* Each streaming response creates a new MOQT group
* TaskStatusUpdateEvent (state changes) and TaskArtifactUpdateEvent
  (output data) are individual objects within groups
* Groups represent execution phases (initialization, progress, completion)

### A2A Agent Card with MOQT Extension {#a2a-agent-card}

When operating over PACE, the A2A Agent Card includes a `moqt` extension
block:

~~~json
{
  "name": "research-assistant",
  "protocolVersion": "0.3.0",
  "capabilities": {"streaming": true, "pushNotifications": true},
  "skills": [{"id": "web-research", "name": "Web Research"}],
  "authentication": {"schemes": ["bearer", "oauth2"]},
  "moqt": {
    "relayEndpoint": "moqt://relay.example.com:4443",
    "webTransportEndpoint": "https://relay.example.com:4443/moqt",
    "namespace": ["pace", "agents", "research-assistant"],
    "supportedExtensions": ["pace-v1"],
    "maxConcurrentSubscriptions": 100,
    "cacheTTL": 300
  },
  "signature": "base64-encoded-ed25519-signature"
}
~~~

The `moqt` extension fields:

| Field | Description |
|-------|-------------|
| `relayEndpoint` | Native QUIC endpoint for the MOQT relay |
| `webTransportEndpoint` | WebTransport endpoint (alternative connectivity) |
| `namespace` | Agent's namespace prefix as array |
| `supportedExtensions` | MOQT/PACE extensions supported |
| `maxConcurrentSubscriptions` | Maximum subscriptions the agent handles |
| `cacheTTL` | Cache duration for the agent card (seconds) |

## MCP Binding {#mcp-binding}

The Model Context Protocol {{MCP}} binding enables tool and resource
access for agents. Within a PACE session, MCP tracks use the `"mcp/"`
prefix under the agent's session namespace:

~~~
Namespace: ("pace", "agents", {server-id}, {session-id})
Tracks:    "mcp/{subcategory}/{identifier}"
~~~

The complete MCP over MOQT specification — including track structure,
operation mapping, message serialization, Agent Skills architecture,
and relay support — is defined in {{MCP-MOQT}}. PACE adopts that
specification's track semantics, mapping its namespace tuples (e.g.,
`(mcp, {session-id}, tools) -- ({tool-name})`) into PACE track names
(e.g., `"mcp/tools/{tool-name}"`) as described in {{namespace}}.

## AutoGen Binding {#autogen-binding}

AutoGen {{AutoGen}} is a multi-agent conversation framework. This
binding maps AutoGen's conversation patterns to MOQT within PACE
sessions.

### Namespace Structure

~~~
Namespace: ("pace", "agents", {runtime-id}, {session-id})
Tracks:    "autogen/{subcategory}/{identifier}"
~~~

Where `runtime-id` is the AutoGen runtime instance identifier.

| Track Pattern | Purpose |
|---------------|---------|
| `autogen/message/{conversation-id}` | Inter-agent messages |
| `autogen/control/{command}` | Runtime control |
| `autogen/state/{state-key}` | Agent state sync |
| `autogen/result/{task-id}` | Final outputs |

### Message Format

AutoGen messages are serialized as JSON with the following structure:

~~~json
{
  "sender": "agent-name",
  "recipient": "agent-name | broadcast",
  "content": "message content or structured data",
  "metadata": {
    "conversation_id": "conv-123",
    "turn": 5,
    "role": "assistant | user | system"
  }
}
~~~

### Conversation Patterns

AutoGen's conversation patterns map to MOQT as follows:

Two-Agent Chat:
: Each agent publishes to their message track. Agents subscribe to
  their conversation partner's track.

Group Chat:
: A coordinator agent manages turn-taking. All agents subscribe to
  the coordinator's broadcast track.

Nested Chat:
: Hierarchical conversations use nested session-ids. An outer agent
  creates a child PACE session for the inner conversation, linking
  it to the parent via delegation chains.

### Priority Mapping

| AutoGen Message Type | MOQT Priority Range |
|----------------------|---------------------|
| Termination signals | 0-31 |
| Human input requests | 32-63 |
| Agent responses | 64-95 |
| Function results | 96-127 |
| State updates | 128-159 |
| Logging/debug | 160-255 |

## Generic JSON-RPC Binding {#jsonrpc-binding}

This binding provides a baseline for custom protocols using JSON-RPC 2.0
messaging.

### Namespace Structure

~~~
Namespace: ("pace", "agents", {agent-id}, {session-id})
Tracks:    "ext/{protocol-name}/{subcategory}/{identifier}"
~~~

Where `protocol-name` is the custom protocol identifier.

| Track Pattern | Purpose |
|---------------|---------|
| `ext/{proto}/rpc/{request-id}` | Request/response |
| `ext/{proto}/stream/{stream-id}` | Streaming data |
| `ext/{proto}/event/{event-type}` | Async events |

### Message Format

Messages follow standard JSON-RPC 2.0:

~~~json
{
  "jsonrpc": "2.0",
  "method": "protocol.method",
  "params": {},
  "id": "request-id"
}
~~~

### Extension Mechanism

Custom protocols extend this binding by defining additional track
subcategories, custom message schemas within JSON-RPC params,
protocol-specific priorities, and custom MOQT extension headers.
Implementations SHOULD document extensions and MAY register them
in the IANA PACE Protocol Binding Registry.

## Multi-Agent Orchestration Patterns {#orchestration}

Common coordination patterns built on PACE sessions and MOQT fan-out:

Sequential:
: Each agent subscribes to its predecessor's response track and
  publishes to the next agent's request track, forming a pipeline.

Concurrent (Broadcast):
: A coordinator publishes a single request; relay fan-out delivers
  it to all subscribing specialists. Results are published back to
  tracks the coordinator subscribes to.

Handoff:
: Agent A publishes a HANDOFF message on the control track. Agent B
  subscribes to the task track, receives cached context from the
  relay, and continues execution without explicit state transfer.

Hierarchical:
: Coordinators create child PACE sessions for sub-task delegation.
  Delegation chains ensure authorization propagates through the
  hierarchy (see {{topologies}}).


# Scalability and Reliability {#scalability}

PACE inherits MOQT's relay architecture for geographic distribution
and load management:

* **Subscription Aggregation**: Multiple subscribers to the same track
  result in a single upstream subscription, reducing origin load
* **Geographic Locality**: Edge relays cache content close to
  subscribers, minimizing round-trip latency
* **Fault Isolation**: Relay failures are localized; other paths
  continue operating

## Failure Modes and Recovery

| Failure | Detection | Recovery |
|---------|-----------|----------|
| Agent network loss | QUIC idle timeout | Connection migration, session resume |
| Relay failure | Subscription timeout | Failover to alternate relay |
| Agent crash | Session heartbeat miss | Session suspended, await resume |
| Prolonged outage | Session timeout | Session closed, state checkpointed |

Session recovery mechanics are defined in {{session-recovery}}.

# Security Considerations

## Threat Model

PACE considers the following threats:

* Unauthorized agents joining sessions or impersonating legitimate agents
* Man-in-the-middle attacks on agent communications
* Privilege escalation through delegation chain manipulation
* Denial of service via excessive session creation or message flooding
* Data exfiltration through compromised relay nodes
* Hallucination-driven operations by compromised or malfunctioning agents

## Mitigations

* All transport is encrypted via TLS 1.3 (QUIC requirement)
* Agent identity tokens are cryptographically signed with short expiry
* Delegation chains are validated end-to-end at each hop
* Relay authorization via MOQT Common Access Tokens restricts namespace access
* Rate limiting at relay nodes prevents flooding
* Confirmation requirements for high-risk operations prevent
  hallucination-driven damage
* Session timeout and explicit termination prevent resource exhaustion

## Relay Trust Model

MOQT relays are trusted for routing but not content inspection. Relay
operators:

* MUST NOT inspect or modify message payloads
* MUST enforce namespace-level access control
* MUST implement rate limiting and abuse prevention
* MAY cache objects for operational efficiency
* MUST NOT retain cached content beyond operational necessity

For end-to-end confidentiality from relay operators, agents MAY
implement payload encryption above the PACE layer.

# IANA Considerations

## MOQT Setup Parameter Registry

This document requests registration of the following MOQT setup parameters:

| Parameter Name | ID | Description |
|----------------|-----|-------------|
| pace-version | 0x50414301 | PACE protocol version |
| agent-identity | 0x50414302 | Agent identity token reference |
| supported-protocols | 0x50414303 | Application protocol bitmask |
| auth-schemes | 0x50414304 | Authentication scheme identifiers |
| session-capabilities | 0x50414305 | Session capability flags |

## PACE Protocol Binding Registry

IANA is requested to create a registry for PACE protocol bindings.
Each entry contains:

* Protocol Identifier (string)
* Protocol Version
* Namespace Prefix Pattern
* Reference Document

Initial entries:

| Protocol ID | Version | Track Name Pattern | Reference |
|-------------|---------|-------------------|-----------|
| a2a | 0.3.0 | `a2a/{sub}/{id}` | This document |
| mcp | 2025-06-18 | `mcp/{sub}/{id}` | This document |
| autogen | 0.4 | `autogen/{sub}/{id}` | This document |
| (generic) | - | `ext/{proto}/{sub}/{id}` | This document |

## PACE Message Type Registry

IANA is requested to create a registry for PACE session control
message types:

| Message Type | Code | Description |
|--------------|------|-------------|
| SESSION_INIT | 0x01 | Initiate session establishment |
| SESSION_ACCEPT | 0x02 | Accept session establishment |
| SESSION_REJECT | 0x03 | Reject session establishment |
| SESSION_UPDATE | 0x04 | Update session parameters |
| SESSION_SUSPEND | 0x05 | Suspend active session |
| SESSION_RESUME | 0x06 | Resume suspended session |
| SESSION_CLOSE | 0x07 | Terminate session |
| SESSION_JOIN | 0x08 | Join multi-party session |
| SESSION_LEAVE | 0x09 | Leave multi-party session |

--- back

# Transport Comparison {#transport-comparison}

The following table compares MOQT (as used by PACE) with alternative
transports for agent communication:

| Feature | HTTP/JSON-RPC | gRPC | REST/SSE | MOQT (PACE) |
|---------|---------------|------|----------|--------------|
| Pub/Sub Native | No | Limited | No | Yes |
| Multi-party Broadcast | Polling | N/A | Fan-out only | Native fan-out |
| Relay/CDN Support | Separate infra | N/A | CDN possible | Built-in |
| Priority QoS | Application layer | Per-stream | None | Per-object (0-255) |
| Connection Migration | No | Limited | No | QUIC native |
| Late Join | N/A | N/A | N/A | Group-based |
| Streaming Granularity | Message-level | Stream | SSE events | Object/Group |
| Discovery | Well-known URI | Service registry | Well-known URI | SUBSCRIBE_NAMESPACE |
| Session Recovery | Re-establish | Reconnect | Reconnect | Relay cache + resume |
| Multi-Modal Concurrent | Multiple conns | Multiple streams | Multiple conns | Single session |

# Example Workflows {#example-workflows}

This appendix illustrates common PACE workflows end-to-end, showing
how agents use the namespace structure, session establishment, and
protocol bindings defined in this document.

## Agent-to-Agent: Task Delegation

Agent A (a coordinator) delegates a research task to Agent B. This
is a point-to-point session using the A2A binding.

**Setup**: Agent A generates session-id `s1` (a UUID) and establishes
a session with Agent B via the flow in {{session-management}}.

**Resulting namespace layout**:

~~~
Agent A publishes:
  ("pace","agents","agent-a","s1") -- "ctrl"            (SESSION_INIT)
  ("pace","agents","agent-a","s1") -- "a2a/request/r1"  (task request)

Agent B publishes:
  ("pace","agents","agent-b","s1") -- "ctrl"            (SESSION_ACCEPT)
  ("pace","agents","agent-b","s1") -- "a2a/response/r1" (task result)
~~~

**Flow**:

1. A publishes SESSION_INIT on its `"ctrl"` track and sends an invite
   to B's inbox
2. B accepts, subscribes to A's session namespace, publishes
   SESSION_ACCEPT on its own `"ctrl"` track
3. A subscribes to B's session namespace
4. A publishes a JSON-RPC request on `"a2a/request/r1"`:
   `{"jsonrpc":"2.0","method":"message/send","params":{...},"id":"r1"}`
5. B receives the request (via its subscription to A's namespace),
   processes it, and publishes the result on `"a2a/response/r1"`
6. A receives the response via its subscription to B's namespace
7. Either agent publishes SESSION_CLOSE on `"ctrl"` to terminate

## Agent-to-Tool: MCP Tool Invocation

Agent A needs to read a file using a filesystem tool (an MCP server).

**Setup**: Agent A generates session-id `s2` and establishes a session
with the filesystem tool.

**Resulting namespace layout**:

~~~
Agent A publishes:
  ("pace","agents","agent-a","s2") -- "ctrl"
  ("pace","agents","agent-a","s2") -- "mcp/tools/readFile"  (tool call)

Tool publishes:
  ("pace","agents","fs-tool","s2") -- "ctrl"
  ("pace","agents","fs-tool","s2") -- "mcp/tools/readFile"  (tool result)
~~~

**Flow**:

1. A establishes a session with the tool (SESSION_INIT / ACCEPT)
2. A publishes a tool call on `"mcp/tools/readFile"`:
   `{"jsonrpc":"2.0","method":"tools/call","params":{"name":"readFile",
   "arguments":{"path":"/data/report.csv"}},"id":"t1"}`
3. Tool receives the call, reads the file, publishes the result on its
   own `"mcp/tools/readFile"` track
4. A receives the file contents
5. A may issue additional tool calls within the same session or close it

## Multi-Agent Collaboration

Agent A (coordinator) creates a research session and invites Agent B
(web researcher) and Agent C (data analyst) to collaborate.

**Setup**: Agent A generates session-id `s3`, invites B and C via their
inbox tracks.

**Resulting namespace layout**:

~~~
Agent A publishes:
  ("pace","agents","agent-a","s3") -- "ctrl"     (session mgmt, assignments)
  ("pace","agents","agent-a","s3") -- "chat"     (coordination messages)

Agent B publishes:
  ("pace","agents","agent-b","s3") -- "ctrl"     (SESSION_ACCEPT)
  ("pace","agents","agent-b","s3") -- "chat"     (status updates)
  ("pace","agents","agent-b","s3") -- "a2a/task/research-1"  (findings)

Agent C publishes:
  ("pace","agents","agent-c","s3") -- "ctrl"     (SESSION_ACCEPT)
  ("pace","agents","agent-c","s3") -- "chat"     (status updates)
  ("pace","agents","agent-c","s3") -- "a2a/task/analysis-1"  (results)
~~~

**Subscriptions**: Each agent subscribes to the other two agents'
session namespaces:

* A subscribes to `("pace","agents","agent-b","s3")` and
  `("pace","agents","agent-c","s3")`
* B subscribes to `("pace","agents","agent-a","s3")` and
  `("pace","agents","agent-c","s3")`
* C subscribes to `("pace","agents","agent-a","s3")` and
  `("pace","agents","agent-b","s3")`

**Flow**:

1. A establishes session, B and C accept
2. A publishes task assignments on `"chat"` — the relay fans out
   to both B and C
3. B performs web research, publishes findings incrementally on
   `"a2a/task/research-1"` (using MOQT groups for phases)
4. C subscribes to B's research track, receives findings as they
   arrive, and begins analysis
5. C publishes analysis results on `"a2a/task/analysis-1"`
6. A monitors all progress through its subscriptions and publishes
   a final summary when complete
7. A publishes SESSION_CLOSE — all participants unsubscribe

## Agent-to-Tool with Streaming: Long-Running Operation

Agent A invokes a code-generation tool that produces output
incrementally.

**Setup**: Same as tool invocation — Agent A and the tool share
session-id `s4`.

**Flow**:

1. A publishes a tool call on `"mcp/tools/generateCode"`
2. Tool begins generating code and publishes results using MOQT groups:
   - Group 0: `{"status":"started","language":"python"}`
   - Group 1, Object 0: first code block
   - Group 1, Object 1: second code block
   - Group 2: `{"status":"complete","totalLines":142}`
3. A receives objects as they are published (ascending group order)
4. If A needs to cancel, it publishes a cancellation on `"ctrl"`
5. Tool receives cancellation, stops generation, publishes final
   status

# Acknowledgments

TODO
