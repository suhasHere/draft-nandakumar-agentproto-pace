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
  RFC9297:
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
  WebTransport:
    title: "The WebTransport Protocol Framework"
    date: 2023-08
    author:
    - ins: V. Vasiliev
    seriesinfo:
      RFC: 9297
    target: https://www.rfc-editor.org/rfc/rfc9297
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

--- abstract

This document defines the Protocol for Agent Communication Exchange (PACE),
a session protocol for communication between AI agents and between agents
and tools over Media over QUIC Transport (MOQT). PACE provides session
lifecycle management, multi-modal data exchange (real-time media, chat,
tool calls, file transfers), agent identity verification, and delegated
authorization — all within a unified publish/subscribe transport that
supports point-to-point and point-to-multipoint topologies.

The protocol maps agent communication patterns onto MOQT primitives,
leveraging MOQT's relay infrastructure for scalable fan-out, priority-based
delivery, and graceful recovery from network failures through relay caching
and QUIC connection migration.

--- middle

# Introduction

AI agents are autonomous, adaptive intelligent software systems that use AI
models to complete specific tasks. These agents interact via chat or voice,
making decisions, executing actions, and communicating with other agents and
tools independently. As agent-to-agent and agent-to-tool communication expands
across the Internet, reliable interoperability across platforms and vendors
becomes critical.

The AI agent ecosystem presents unique communication requirements that
existing transport protocols do not fully address:

Agent Identity:
: Agents may need to be authenticated independently of the users they
  represent. Verifiable agent identity enables independent revocation,
  scoped permissions, and auditability of agent-initiated actions.

Capabilities and Collaboration:
: Agents have specialized capabilities enhanced through collaboration.
  This raises considerations for selecting agents and tools, initiating
  communication, and maintaining interactions across network boundaries.

Interaction Characteristics:
: Agent interactions can be long-lived, utilize significant amounts of
  context across various modes (text, audio, video), and require very
  low latency. This introduces considerations around reliability,
  transport session management, and efficient data transport.

Security and Privacy:
: Protecting data over untrusted networks requires mechanisms for identity
  verification, confidentiality, integrity, authenticity, and delegated
  authorization across AI agent chains.

This document defines the Protocol for Agent Communication Exchange (PACE), which addresses
these requirements by providing a session layer over Media over QUIC Transport
(MOQT) {{MoQ-TRANSPORT}}. PACE enables diverse agent protocols to leverage
MOQT's real-time streaming capabilities, built-in prioritization, scalable
relay infrastructure, and efficient multiplexing over QUIC.

## Design Goals

PACE is designed to meet the following objectives:

1. **Session Lifecycle Management**: Provide timed session management
   (short or long-lived) covering establishment, update, context
   handling, and termination.

2. **Multi-Modal Data Exchange**: Support concurrent exchange of
   real-time data (voice/video), semi-real-time data (chat/streaming
   text), and non-real-time data (tool calls/file transfers).

3. **Scalable and Reliable**: Enable highly scalable session management
   that survives network and server failures with graceful recovery.

4. **Flexible Topologies**: Support point-to-point and point-to-multipoint
   communication patterns through relay infrastructure.

5. **Agent Identity and Authorization**: Provide mechanisms for agent
   authentication independent of user identity, with delegated
   authorization and fine-grained behavioral scopes.

6. **Protocol Agnostic**: Serve as a session substrate usable by
   application-layer protocols (A2A, MCP, and others) with appropriate
   layering and extension points.

## Requirements Language

{::boilerplate bcp14-tagged}

# Architecture Overview

{{figure-arch}} illustrates the overall PACE architecture, showing how the
session protocol layers over MOQT and QUIC, and how application protocols
integrate through the extension framework.

~~~
┌──────────────────────────────────────────────────────────────────┐
│                  Application Protocol Layer                       │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌─────────────────┐  │
│  │   A2A    │  │   MCP    │  │ AutoGen  │  │ Custom Protocol │  │
│  │  Tasks   │  │  Tools   │  │ Convos   │  │   Operations    │  │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └───────┬─────────┘  │
└───────┼──────────────┼─────────────┼────────────────┼────────────┘
        │              │             │                │
┌───────▼──────────────▼─────────────▼────────────────▼────────────┐
│              Protocol for Agent Communication Exchange (PACE)                     │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  Session Management │ Identity │ Authorization │ Recovery  │  │
│  └────────────────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  Multi-Modal Channels │ Priority │ Flow Control │ Context  │  │
│  └────────────────────────────────────────────────────────────┘  │
└──────────────────────────────┬───────────────────────────────────┘
                               │
┌──────────────────────────────▼───────────────────────────────────┐
│                       MOQT Transport                              │
│   Pub/Sub │ Namespace Routing │ Relay Caching │ Object Delivery  │
└──────────────────────────────┬───────────────────────────────────┘
                               │
┌──────────────────────────────▼───────────────────────────────────┐
│                    QUIC / WebTransport                            │
│   Encryption (TLS 1.3) │ Multiplexing │ Connection Migration     │
└──────────────────────────────────────────────────────────────────┘
~~~
{: #figure-arch title="PACE Architecture"}

## MOQT as Session Substrate

Media over QUIC Transport (MOQT) {{MoQ-TRANSPORT}} is a publish/subscribe
protocol built on QUIC that delivers low-latency, highly-scalable message
distribution. MOQT decouples publishers from subscribers through
intermediary relay infrastructure, enabling efficient fan-out to many
consumers without requiring direct connections between endpoints.

MOQT provides several properties essential for agent communication:

* **Named Data Addressing**: Content is addressed by hierarchical
  namespace tuples rather than endpoint locations, enabling
  location-independent data retrieval and natural caching

* **Application Layer Multicast**: Relay infrastructure provides
  multicast-like fan-out without requiring network-layer multicast,
  making one-to-many distribution practical across the public Internet

* **Low Latency**: QUIC's 0-RTT connection establishment, stream
  multiplexing to prevent head-of-line blocking, and priority-based
  delivery (0-255 scale) ensure time-critical messages are transmitted first

* **High Scalability**: Publishers connect once to a relay which fans
  out to all subscribers; hierarchical relay networks distribute load
  across geographic regions

* **Fault Tolerance**: Relay redundancy enables failover without
  disrupting active sessions; object caching at relays enables
  recovery from transient disconnections

{{figure-moqt-relay}} illustrates the relay architecture that enables
PACE's scalability and reliability properties.

~~~
PACE Relay Architecture:

  Agent Endpoints              Relay Network                Agent Endpoints

┌──────────────┐                                          ┌──────────────┐
│   Agent A    │──publish──┐                      ┌──────▶│   Agent X    │
│  (initiator) │           │   ┌──────────────┐   │       │ (responder)  │
└──────────────┘           ├──▶│              │───┤       └──────────────┘
                           │   │  MOQT Relay  │   │
┌──────────────┐           │   │              │   │       ┌──────────────┐
│   Agent B    │──publish──┘   │ ┌──────────┐ │   ├──────▶│   Agent Y    │
│   (tool)     │               │ │  Cache   │ │   │       │ (observer)   │
└──────────────┘               │ └──────────┘ │   │       └──────────────┘
                               └──────┬───────┘   │
                                      │           │       ┌──────────────┐
                                      ▼           └──────▶│   Agent Z    │
                              ┌──────────────┐            │ (collaborator)│
                              │  Edge Relay  │            └──────────────┘
                              │ ┌──────────┐ │
                              │ │  Cache   │ │───▶ More Agents
                              │ └──────────┘ │
                              └──────────────┘
~~~
{: #figure-moqt-relay title="PACE Relay Architecture"}

# Session Management {#session-management}

An PACE session represents a logical communication context between two or more
agents. Sessions are the fundamental unit of interaction, providing lifetime
management, context preservation, and failure recovery.

## Session Lifecycle

Sessions progress through defined states:

~~~
Session State Machine:

  ┌───────────┐    establish     ┌───────────┐
  │           │─────────────────▶│           │
  │  IDLE     │                  │  PENDING  │
  │           │◀─────────────────│           │
  └───────────┘     reject       └─────┬─────┘
                                       │ accept
                                       ▼
                                 ┌───────────┐
                     update      │           │     suspend
                  ┌─────────────▶│  ACTIVE   │──────────────┐
                  │              │           │              │
                  │              └─────┬─────┘              ▼
                  │                    │              ┌───────────┐
                  │                    │ terminate    │ SUSPENDED │
                  │                    ▼              │           │
                  │              ┌───────────┐       └─────┬─────┘
                  │              │           │             │ resume
                  │              │  CLOSED   │◀────────────┘
                  │              │           │   (or timeout→CLOSED)
                  └──────────────└───────────┘
~~~
{: #figure-session-states title="Session State Machine"}

IDLE:
: No session exists. Agent is available to initiate or accept sessions.

PENDING:
: Session establishment in progress. Capability negotiation and
  authentication are being performed.

ACTIVE:
: Session is established and data exchange is occurring. Sessions
  can be updated (renegotiate capabilities, add participants) while active.

SUSPENDED:
: Session is temporarily inactive but state is preserved. The session
  may be resumed without full re-establishment. Sessions automatically
  transition to CLOSED after a configurable timeout.

CLOSED:
: Session has terminated. Resources are released and state is cleaned up.

## Session Establishment

Session establishment combines MOQT connection setup with PACE-specific
negotiation of session parameters, agent identity, and capabilities.

~~~
Session Establishment Flow:

Agent A                          MOQT Relay                        Agent B
  │                                  │                                │
  │── QUIC/WebTransport Connect ────▶│                                │
  │◀── Connection Established ───────│                                │
  │                                  │                                │
  │── MOQT CLIENT_SETUP ───────────▶│                                │
  │◀── MOQT SERVER_SETUP ───────────│                                │
  │                                  │                                │
  │── PUBLISH_NAMESPACE ────────────▶│                                │
  │   (pace/{session}/ctrl/agent-a)  │                                │
  │                                  │                                │
  │── SESSION_INIT ─────────────────▶│── SESSION_INIT ───────────────▶│
  │   (identity, capabilities,       │   (forwarded)                  │
  │    requested modalities,         │                                │
  │    session parameters)           │                                │
  │                                  │                                │
  │                                  │◀── SESSION_ACCEPT ─────────────│
  │◀── SESSION_ACCEPT ──────────────│   (identity, capabilities,     │
  │   (negotiated params)            │    accepted modalities)        │
  │                                  │                                │
  │◀═══════ Session ACTIVE ════════▶│◀═══════════════════════════════▶│
~~~
{: #figure-session-establish title="Session Establishment"}

During session establishment, agents exchange the following information:

### Session Parameters

* `session-id`: Globally unique session identifier (UUID)
* `session-type`: Short-lived (bounded duration) or long-lived (indefinite)
* `session-timeout`: Maximum idle duration before automatic termination
* `max-participants`: Maximum number of agents in the session
* `supported-modalities`: Bitmask of data modalities the agent can handle

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

PACE supports both short-lived and long-lived sessions to accommodate
different agent interaction patterns:

Short-Lived Sessions:
: Bounded duration sessions for discrete operations such as a single tool
  invocation or query. The session has a defined maximum lifetime and
  automatically terminates upon completion or timeout. Optimized for
  low-overhead interactions.

Long-Lived Sessions:
: Indefinite sessions for ongoing collaboration, monitoring, or
  persistent agent relationships. These sessions survive idle periods
  through the SUSPENDED state and can be resumed without full
  re-establishment. Suitable for complex multi-step tasks, ongoing
  advisory relationships, or persistent tool connections.

Session timing is governed by the `session-timeout` parameter, which
defines the maximum idle period before automatic transition to CLOSED.
Agents MAY send keepalive messages to prevent timeout during periods
of inactivity.

## Session Update

Active sessions can be updated to renegotiate parameters without
terminating the session:

* Adding or removing data modalities
* Adjusting priority mappings
* Adding participants (transitioning from point-to-point to multipoint)
* Updating authorization scopes
* Extending session timeout

Updates are performed by publishing a SESSION_UPDATE message on the
session control track. All participants MUST acknowledge the update
before new parameters take effect.

## Session Recovery {#session-recovery}

PACE provides graceful recovery from network and server failures through
multiple mechanisms:

QUIC Connection Migration:
: QUIC's connection ID mechanism allows sessions to survive network
  path changes (e.g., WiFi to cellular) without re-establishing the
  MOQT session.

Relay Caching:
: MOQT relays cache recent objects, allowing agents that reconnect
  after transient disconnections to receive missed messages from cache
  without requiring the peer to retransmit.

Session Resumption:
: Agents that experience prolonged disconnections can resume SUSPENDED
  sessions by re-authenticating and providing the session-id. The
  relay provides cached context from the point of disconnection.

State Checkpointing:
: Agents SHOULD periodically publish session state checkpoints on a
  dedicated state track. These checkpoints enable recovery of session
  context after relay failures.

~~~
Session Recovery Flow:

Agent A              MOQT Relay              Agent B
  │                      │                      │
  │══ ACTIVE SESSION ═══▶│◀═════════════════════│
  │                      │                      │
  ╳ (network failure)    │                      │
  │                      │                      │
  │                      │  (relay caches       │
  │                      │   recent objects)    │
  │                      │                      │
  │── QUIC Reconnect ──▶│                      │
  │── SESSION_RESUME ───▶│                      │
  │   (session-id, last  │                      │
  │    received seq)     │                      │
  │                      │                      │
  │◀── Cached Objects ───│  (catch-up from      │
  │   (missed messages)  │   cache)             │
  │                      │                      │
  │══ SESSION RESUMED ══▶│◀═════════════════════│
~~~
{: #figure-session-recovery title="Session Recovery via Relay Caching"}

## Session Termination

Sessions are terminated explicitly via SESSION_CLOSE or implicitly via
timeout. Upon termination:

1. All active subscriptions are cancelled
2. Pending operations receive cancellation notifications
3. Session state and cached objects are retained for a configurable
   grace period to handle in-flight messages
4. After the grace period, all session resources are released

# Agent Identity and Discovery {#identity-discovery}

## Agent Identity Model

PACE defines an identity model where agents are authenticated
independently of the users they represent. This separation enables:

* Independent revocation of agent credentials without affecting user accounts
* Scoped permissions specific to agent capabilities
* Auditability of agent-initiated actions distinct from user actions
* Delegation chains where agents act on behalf of other agents

### Agent Identity Token

Each agent presents an identity token during session establishment.
The token contains:

~~~
Agent Identity Token Structure:

┌──────────────────────────────────────────────────────────┐
│                    Token Header                           │
│  Algorithm │ Token Type │ Key ID                          │
├──────────────────────────────────────────────────────────┤
│                    Token Claims                           │
│  ┌────────────────────────────────────────────────────┐  │
│  │  agent-id: Globally unique agent identifier        │  │
│  │  issuer: Identity provider that issued the token   │  │
│  │  subject: User or organization the agent serves    │  │
│  │  capabilities: Agent capability descriptors        │  │
│  │  scopes: Authorized operation scopes               │  │
│  │  issued-at: Token issuance timestamp               │  │
│  │  expires-at: Token expiration timestamp            │  │
│  │  delegation-chain: Parent agent references         │  │
│  └────────────────────────────────────────────────────┘  │
├──────────────────────────────────────────────────────────┤
│                    Signature                              │
│  Cryptographic signature from issuing authority           │
└──────────────────────────────────────────────────────────┘
~~~
{: #figure-identity-token title="Agent Identity Token Structure"}

The token format is based on JWT {{RFC7519}} with agent-specific claims.

### Delegation Chains

When an agent acts on behalf of another agent (e.g., a sub-agent
invoked to handle a specialized task), the identity token includes
a delegation chain that traces the authorization path:

~~~
Delegation Chain Example:

User "alice" → Agent "coordinator" → Agent "researcher" → Tool "web-search"

Each agent's token contains:
  delegation-chain: [
    { agent: "coordinator", scope: "research.execute", granted-by: "alice" },
    { agent: "researcher", scope: "web.search", granted-by: "coordinator" }
  ]
~~~

Receiving agents and tools can verify the complete delegation chain to
ensure each link in the chain has appropriate authorization.

## Agent Discovery

PACE provides in-band agent discovery through MOQT's namespace
operations, enabling agents to find and evaluate potential collaborators
within a session context.

### Discovery Protocol

Agents advertise their presence using PUBLISH_NAMESPACE and discover
others using SUBSCRIBE_NAMESPACE:

~~~
Agent Discovery Flow:

Agent A                     MOQT Relay                     Agent B
  │                             │                             │
  │─ SUBSCRIBE_NAMESPACE ──────▶│                             │
  │  (pace/{session}/discovery) │                             │
  │                             │◀─ SUBSCRIBE_NAMESPACE ──────│
  │                             │  (pace/{session}/discovery) │
  │                             │                             │
  │─ PUBLISH_NAMESPACE ────────▶│                             │
  │  (pace/{session}/discovery/ │                             │
  │   agent-a)                  │                             │
  │                             │─ NAMESPACE ────────────────▶│
  │                             │  (agent-a available)        │
  │                             │                             │
  │                             │◀─ PUBLISH_NAMESPACE ────────│
  │                             │  (pace/{session}/discovery/ │
  │                             │   agent-b)                  │
  │◀─ NAMESPACE ────────────────│                             │
  │  (agent-b available)        │                             │
  │                             │                             │
  │─ SUBSCRIBE ────────────────▶│─ SUBSCRIBE ────────────────▶│
  │  (agent-b/capability-card)  │                             │
  │◀─ OBJECT (Agent Card) ──────│◀─ OBJECT (Agent Card) ──────│
~~~
{: #figure-discovery title="Agent Discovery via MOQT Namespace Operations"}

### Agent Capability Card

Each agent publishes a capability card as an MOQT object on its
discovery track. The card advertises the agent's identity, capabilities,
supported modalities, and connection parameters:

~~~json
{
  "agent-id": "researcher-agent-01",
  "name": "Research Assistant",
  "description": "Specialized agent for web research and summarization",
  "version": "1.2.0",
  "identity": {
    "issuer": "https://identity.example.com",
    "public-key-id": "key-2026-06"
  },
  "capabilities": {
    "modalities": ["text", "structured-data", "files"],
    "streaming": true,
    "multi-party": true,
    "max-concurrent-tasks": 10
  },
  "supported-protocols": ["a2a", "mcp"],
  "authentication": {
    "schemes": ["bearer", "dpop", "mtls"],
    "token-endpoint": "https://auth.example.com/agent/token"
  },
  "transport": {
    "relay-endpoint": "moqt://relay.example.com:4443",
    "namespace-prefix": "pace/session-123/researcher-agent-01",
    "supported-extensions": ["pace-v1"]
  }
}
~~~

# Multi-Modal Data Exchange {#data-exchange}

PACE supports concurrent exchange of multiple data modalities within
a single session, each with appropriate quality of service. This enables
agents to simultaneously conduct text-based reasoning, stream audio/video,
invoke tools, and transfer files.

## Modality Types

PACE defines the following data modality classes:

| Modality | Latency | Examples | Delivery |
|----------|---------|----------|----------|
| Real-time | < 100ms | Voice, video, screen share | Continuous stream |
| Semi-real-time | < 1s | Chat messages, streaming LLM output | Ordered objects |
| Non-real-time | Best effort | Tool calls, file transfers, context | Reliable delivery |

## Channel Architecture

Each modality is mapped to dedicated MOQT tracks (channels) within the
session namespace. Channels provide isolation between modalities while
sharing the same session context and authorization.

~~~
Multi-Modal Channel Layout:

Session Namespace: pace/{session-id}/{agent-id}/

  ├── ctrl/                    (Session control)
  │   ├── session              Track: session lifecycle messages
  │   └── auth                 Track: authorization updates
  │
  ├── rt/                      (Real-time modalities)
  │   ├── audio                Track: voice stream
  │   ├── video                Track: video stream
  │   └── screen               Track: screen share
  │
  ├── chat/                    (Semi-real-time)
  │   ├── {conversation-id}    Track: chat messages
  │   └── {stream-id}         Track: streaming LLM output
  │
  ├── ops/                     (Non-real-time operations)
  │   ├── request              Track: outbound requests
  │   ├── response             Track: responses
  │   └── {operation-id}       Track: operation-specific data
  │
  ├── data/                    (Bulk data)
  │   ├── {transfer-id}        Track: file transfers
  │   └── context              Track: context/memory exchange
  │
  └── discovery/               (Agent discovery)
      └── capability-card      Track: agent card
~~~
{: #figure-channels title="Multi-Modal Channel Layout"}

## Priority and Quality of Service

MOQT's 0-255 priority scale enables differentiated treatment of
messages based on their urgency and modality. PACE defines the
following priority tiers:

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

Request/response interactions use coordinated publish and subscribe
operations through the MOQT relay:

~~~
Request/Response Flow:

Client Agent              MOQT Relay               Server Agent
     │                        │                         │
     │── PUBLISH ────────────▶│── forward ─────────────▶│
     │   (ops/request)        │                         │
     │   Object: {            │                         │
     │     req-id, method,    │                         │
     │     params, auth-token │                         │
     │   }                    │                         │
     │                        │                         │
     │── SUBSCRIBE ──────────▶│                         │
     │   (ops/response/{id})  │                         │
     │                        │                         │
     │                        │    [Server processes]   │
     │                        │                         │
     │                        │◀── PUBLISH ─────────────│
     │                        │   (ops/response/{id})   │
     │◀── OBJECT ─────────────│                         │
     │   (Response payload)   │                         │
~~~
{: #figure-request-response title="Request/Response Pattern"}

## Streaming Pattern {#streaming}

Long-running operations produce incremental results as a stream of
MOQT objects organized into groups representing execution phases:

~~~
Streaming Operation Flow:

Client                   MOQT Relay                   Server
  │                          │                          │
  │── SUBSCRIBE ────────────▶│── SUBSCRIBE ────────────▶│
  │   (ops/{operation-id})   │                          │
  │                          │                          │
  │                          │  [Group 0: Init]         │
  │◀── Status: "started" ────│◀── Object 0 ────────────│
  │                          │                          │
  │                          │  [Group 1: Progress]     │
  │◀── Data: partial ────────│◀── Object 0 ────────────│
  │◀── Data: more ───────────│◀── Object 1 ────────────│
  │                          │                          │
  │                          │  [Group 2: Complete]     │
  │◀── Data: final ──────────│◀── Object 0 ────────────│
  │◀── Status: "done" ───────│◀── Object 1 ────────────│
  │                          │                          │
  │── UNSUBSCRIBE ──────────▶│── UNSUBSCRIBE ──────────▶│
~~~
{: #figure-streaming title="Streaming Operation with Groups"}

Groups serve as synchronization points. The server advances to a new
group when transitioning between execution phases. Late-joining
subscribers receive the latest complete group from relay cache.

## Real-Time Media Exchange

For voice and video communication between agents (or between agents
and humans), PACE maps media streams to dedicated real-time tracks
with appropriate priority and delivery semantics:

* Audio frames are published as individual MOQT objects with descending
  group order (newest-first delivery for real-time playback)
* Video frames use group-based organization where each group represents
  a decodable unit (e.g., GOP)
* MOQT's priority mechanism ensures media frames preempt lower-priority
  data when bandwidth is constrained

# Communication Topologies {#topologies}

PACE supports multiple communication topologies through MOQT's relay
infrastructure.

## Point-to-Point

Direct communication between two agents through a relay:

~~~
Point-to-Point:

  Agent A ──────▶ Relay ──────▶ Agent B
         ◀──────        ◀──────
~~~

This is the simplest topology, used for tool invocation, simple task
delegation, and bilateral collaboration.

## Point-to-Multipoint (Fan-Out)

One agent publishes to multiple subscribers through relay fan-out:

~~~
Point-to-Multipoint:

                         ┌──▶ Agent B (subscriber)
                         │
  Agent A ──▶ Relay ─────┼──▶ Agent C (subscriber)
  (publisher)            │
                         └──▶ Agent D (subscriber)
~~~

This topology enables broadcast notifications, shared context
distribution, and one-to-many task delegation where multiple agents
observe the same operation.

## Multi-Party Collaboration

Multiple agents publish and subscribe within a shared session,
enabling group collaboration:

~~~
Multi-Party:

  Agent A ◀──┐         ┌──▶ Agent A
             │         │
  Agent B ◀──┼─ Relay ─┼──▶ Agent B
             │         │
  Agent C ◀──┘         └──▶ Agent C

  (All agents publish and subscribe to shared tracks)
~~~

Multi-party sessions use MOQT namespace operations to manage
participant membership. Each participant publishes to their own
tracks and subscribes to relevant tracks from other participants.

### Participant Management

Adding a participant to an active multi-party session:

1. New agent establishes MOQT connection to the relay
2. New agent publishes SESSION_JOIN on the session control track
3. Existing participants receive the join notification
4. Existing participants publish updated capability information
5. New agent subscribes to relevant tracks from other participants
6. Session state (participant list, shared context) is updated

## Hierarchical Teams

Agents can form hierarchical structures where a coordinator delegates
subtasks to specialist agents:

~~~
Hierarchical Team:

                     ┌──────────────┐
                     │ Coordinator  │
                     │    Agent     │
                     └──────┬───────┘
                            │
              ┌─────────────┼─────────────┐
              │             │             │
       ┌──────▼─────┐ ┌────▼──────┐ ┌────▼──────┐
       │ Researcher │ │  Writer   │ │ Reviewer  │
       │   Agent    │ │  Agent    │ │   Agent   │
       └──────┬─────┘ └───────────┘ └───────────┘
              │
       ┌──────▼─────┐
       │ Web Search │
       │   Tool     │
       └────────────┘
~~~

Each level in the hierarchy operates as a separate PACE session with
its own authorization scope. The coordinator's delegation chain is
extended at each level, maintaining an auditable path from the
original user authorization.

# Authorization and Security {#authorization}

## Authorization Model

PACE implements a fine-grained, behavior-driven authorization model
where access tokens are scoped to specific operations an agent is
permitted to perform.

### Behavior-Driven Scopes

Unlike traditional role-based access, PACE scopes are bound to
specific agent behaviors:

~~~
Scope Structure:

  {domain}:{resource}:{action}:{constraints}

Examples:
  research:web:search:max-queries=10
  tools:filesystem:read:path=/data/*
  agents:coordinator:delegate:max-depth=2
  chat:session-123:send:modality=text
  media:session-123:publish:type=audio,video
~~~

Scopes can include dynamic constraints that limit the scope based on
runtime context (time bounds, resource limits, geographic restrictions).

### Delegated Authorization

When agents invoke other agents or tools on behalf of a user, PACE
supports delegated authorization that preserves the principle of
least privilege:

~~~
Delegated Authorization Flow:

User ──── grants scope S ────▶ Agent A
                                  │
                    Agent A requests sub-scope S' ⊂ S
                                  │
                                  ▼
                Token Service issues S' token for Agent B
                                  │
                                  ▼
              Agent A ── invokes with S' ──▶ Agent B
                                              │
                              Agent B requests S'' ⊂ S'
                                              │
                                              ▼
                            Agent B ── uses S'' ──▶ Tool
~~~
{: #figure-delegated-auth title="Delegated Authorization"}

Each delegation narrows the scope, ensuring downstream agents cannot
exceed the permissions of their delegator. The complete delegation
chain is verifiable by any participant.

### Authorization Token Exchange

Authorization tokens are exchanged during session establishment and
can be refreshed during active sessions without interruption:

1. Agent presents initial authorization token in SESSION_INIT
2. Receiving agent validates the token and delegation chain
3. If additional scopes are needed, agents negotiate via the auth
   control channel
4. Token refresh is performed proactively before expiration

### Confirmation and Evidence

For high-risk operations, PACE supports confirmation requirements
where an agent must present evidence that a human or authorized
system has approved the action:

* `confirmation-required`: Operation requires explicit approval
* `evidence-type`: Type of evidence (human-approval, policy-check, mfa)
* `evidence-token`: Cryptographic proof of confirmation

This mechanism mitigates the impact of compromised agents or
hallucination-driven actions by requiring out-of-band verification
for sensitive operations.

## Transport Security

All PACE communication is encrypted via TLS 1.3 as provided by the
underlying QUIC connection. Additionally:

* Agent identity tokens are cryptographically signed and verifiable
* Session control messages are integrity-protected
* Relay nodes operate on encrypted traffic without access to payload
  content (unless explicitly authorized as trusted intermediaries)
* MOQT's Common Access Token {{MoQ-C4M}} provides relay-level
  authorization for namespace access

## Privacy Considerations

* Agents SHOULD minimize the context and data shared in sessions to
  what is necessary for the task
* Session metadata (participant identities, timing, access patterns)
  should be protected from unauthorized observation
* Long-lived sessions SHOULD support forward secrecy through periodic
  key rotation
* Relay operators MUST NOT retain session content beyond the
  operationally required caching period

# Namespace Organization {#namespace}

PACE uses MOQT's hierarchical namespace system for routing, isolation,
and multiplexing of sessions and protocols.

## Namespace Hierarchy

~~~
PACE Namespace Structure:

pace / {session-id} / {agent-id} / {category} -- {track-name}

Fields:
  pace          Protocol identifier (fixed)
  session-id    Unique session identifier
  agent-id      Publishing agent's identifier
  category      Message category (ctrl, rt, chat, ops, data, discovery)

Track Name:
  Specific identifier within the category (e.g., request-id,
  stream-id, modality type)
~~~
{: #figure-namespace title="PACE Namespace Structure"}

## Application Protocol Multiplexing

Multiple application protocols can coexist within a single PACE
session by using protocol-specific sub-categories:

| Protocol | Category Prefix | Example Namespace |
|----------|----------------|-------------------|
| PACE Core | `ctrl`, `rt`, `discovery` | `pace/s1/agent-a/ctrl` |
| A2A | `a2a` | `pace/s1/agent-a/a2a/task` |
| MCP | `mcp` | `pace/s1/agent-a/mcp/tools` |
| Custom | `ext/{protocol}` | `pace/s1/agent-a/ext/custom/rpc` |

This enables agents speaking different application protocols to
share the same session infrastructure while maintaining message
isolation.

## Relay Routing

MOQT relays route subscriptions based on namespace prefixes. The
hierarchical structure enables:

* Session-level routing: All traffic for a session shares a prefix
* Agent-level routing: Traffic to/from specific agents is identifiable
* Category-level routing: Relays can apply different policies per category
  (e.g., prioritize real-time, rate-limit bulk transfers)

# MOQT Transport Binding Layer {#transport-binding}

This section defines the concrete MOQT transport mechanics that
underpin PACE sessions. While {{session-management}} defines session
lifecycle and {{data-exchange}} defines multi-modal channels, this
section specifies the precise mapping of protocol messages to MOQT
primitives, including connection establishment sequences, message
serialization formats, and operation-to-primitive mappings.

## Connection Establishment {#connection-establishment}

Agents using PACE MUST establish either a native QUIC connection
or a WebTransport {{WebTransport}} session as defined in
{{MoQ-TRANSPORT}}. For native QUIC connections, agents MUST use the
ALPN value "moqt". For WebTransport, the protocol is negotiated using
the "WT-Available-Protocols" mechanism as specified in {{MoQ-TRANSPORT}}.

The connection setup follows this sequence:

~~~
Agent A                                                   Agent B
   |                                                        |
   |──── QUIC/WebTransport Connection ─────────────────────▶|
   |◄─── Connection Established ────────────────────────────|
   |                                                        |
   |──── MOQT CLIENT_SETUP ────────────────────────────────▶|
   |     (ALPN: "moqt",                                     |
   |      pace-version, agent-identity,                     |
   |      supported-protocols, auth-schemes)                |
   |◄─── MOQT SERVER_SETUP ─────────────────────────────────|
   |     (pace-version, agent-identity,                     |
   |      supported-protocols, session-capabilities)        |
   |                                                        |
   |──── PUBLISH_NAMESPACE (discovery) ────────────────────▶|
   |◄─── PUBLISH_NAMESPACE (discovery) ─────────────────────|
   |                                                        |
   |──── Capability Card Exchange ─────────────────────────▶|
   |◄─── Capability Card Exchange ──────────────────────────|
   |                                                        |
   |──── SESSION_INIT ─────────────────────────────────────▶|
   |◄─── SESSION_ACCEPT ────────────────────────────────────|
   |                                                        |
   |◄═══ Protocol Message Exchange ════════════════════════▶|
~~~
{: #figure-connection title="MOQT Connection Establishment Sequence"}

During the MOQT setup phase, agents negotiate the PACE setup
parameters defined in {{session-management}} (pace-version,
agent-identity, supported-protocols, auth-schemes, and
session-capabilities) as MOQT extensions in CLIENT_SETUP and
SERVER_SETUP messages.

## Track Organization {#track-organization}

Agent protocol messages are mapped to MOQT tracks using a hierarchical
namespace structure as defined in {{MoQ-TRANSPORT}}. MOQT namespaces
consist of 1-32 ordered tuple fields, enabling relays to route based
on hierarchical prefixes.

### Full Track Name Structure

~~~
Full Track Name Structure:

Track Namespace (tuple fields):
┌──────────┬──────────┬────────────┬──────────────┐
│ Field 1  │ Field 2  │  Field 3   │   Field 4    │
│ protocol │ session  │  agent-id  │   category   │
└──────────┴──────────┴────────────┴──────────────┘

Track Name:
┌────────────────────────────────────────────────┐
│              action or identifier              │
└────────────────────────────────────────────────┘

Example Full Track Names:
  pace / session-123 / agent-alice / ops/request  -- req-001
  pace / session-123 / agent-bob / discovery      -- capability-card
  pace / session-123 / agent-alice / a2a/stream   -- task-456
  pace / session-123 / agent-alice / mcp/tools    -- read-file
~~~
{: #figure-track-names title="Full Track Name Structure"}

The first namespace field is always "pace" identifying the protocol.
Subsequent fields provide session routing, agent identification, and
category-based message classification as defined in {{namespace}}.

### Track Category Mechanics

Tracks are organized into categories that map to MOQT publish/subscribe
operations:

| Category | Direction | MOQT Mechanism | Purpose |
|----------|-----------|----------------|---------|
| ctrl | Bidirectional | PUBLISH + SUBSCRIBE | Session lifecycle |
| discovery | Publish | PUBLISH_NAMESPACE + OBJECT | Agent advertisement |
| ops/request | Client→Server | PUBLISH + OBJECT | Request messages |
| ops/response | Server→Client | PUBLISH + OBJECT | Response messages |
| rt | Bidirectional | Continuous PUBLISH | Real-time media |
| chat | Bidirectional | PUBLISH + OBJECT | Chat/streaming text |
| data | Bidirectional | PUBLISH + OBJECT(s) | Bulk transfers |

Subscribers discover available tracks within a category using
SUBSCRIBE_NAMESPACE on the category prefix, receiving NAMESPACE
announcements as new tracks appear.

## Message Serialization {#message-serialization}

Agent protocol messages are serialized and encapsulated within MOQT
objects. Each MOQT object contains a header (managed by the MOQT
layer) and a protocol-specific payload:

~~~
MOQT Object Structure:

┌─────────────────────────────────────────────────────────┐
│                 MOQT Object Header                      │
│  Track ID │ Group ID │ Object ID │ Priority │ TTL      │
└─────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────┐
│              PACE Message Envelope                      │
│  ┌─────────────────────────────────────────────────────┐│
│  │  version (1 byte) │ flags (1 byte) │ length (varint)││
│  ├─────────────────────────────────────────────────────┤│
│  │         Serialized Protocol Message                 ││
│  │  (JSON-RPC 2.0, JSON, or protocol-specific format)  ││
│  └─────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────┘
~~~
{: #figure-object-structure title="MOQT Object Structure with PACE Envelope"}

The PACE message envelope prepends minimal framing:

* `version` (1 byte): PACE envelope version (currently 0x01)
* `flags` (1 byte): Message flags (0x01=compressed, 0x02=fragmented,
  0x04=encrypted)
* `length` (varint): Length of the serialized protocol message

Protocol bindings SHOULD preserve native message formats where possible
to maintain compatibility with existing protocol implementations. For
example, A2A messages retain their JSON-RPC 2.0 format; the PACE
envelope simply wraps the serialized JSON bytes.

## Operation-to-Primitive Mapping {#operation-mapping}

The following table provides the complete mapping of common agent
communication patterns to MOQT primitives:

| Operation Pattern | MOQT Mechanism | Description |
|-------------------|----------------|-------------|
| One-shot request | PUBLISH + OBJECT | Single request published to a track |
| Streaming request | PUBLISH + multiple OBJECTs | Request with incremental data across objects |
| Resource fetch | SUBSCRIBE + OBJECT | Subscribe to retrieve a specific resource |
| Resource listing | SUBSCRIBE_NAMESPACE | Discover available resources via namespace |
| Cancellation | OBJECT on control track | Cancel signal published to control track |
| Subscription | SUBSCRIBE (ongoing) | Long-lived subscription for updates |
| Notification push | PUBLISH to subscriber track | Server-initiated event delivery |
| Discovery | PUBLISH_NAMESPACE + SUBSCRIBE_NAMESPACE | In-band agent/service discovery |
| Broadcast | PUBLISH + relay fan-out | One-to-many distribution |

# Protocol Bindings {#protocol-bindings}

This section defines concrete protocol bindings that map application
protocol semantics to the MOQT transport layer defined in
{{transport-binding}}. Each binding operates within PACE sessions
({{session-management}}) and uses the channel architecture defined
in {{data-exchange}}.

## Binding Architecture

~~~
┌─────────────────────────────────────────────────────────────────────┐
│                    Agent Applications                                │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐ │
│  │ A2A Agent   │  │ MCP Host    │  │ AutoGen     │  │ Custom      │ │
│  │             │  │             │  │ Agent       │  │ Agent       │ │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘ │
└─────────┼────────────────┼────────────────┼────────────────┼────────┘
          │                │                │                │
┌─────────▼────────────────▼────────────────▼────────────────▼────────┐
│                 Protocol Binding Layer                               │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐ │
│  │ A2A Binding │  │ MCP Binding │  │ AutoGen     │  │ Generic     │ │
│  │ (§7.2)      │  │ (§7.3)      │  │ Binding     │  │ JSON-RPC    │ │
│  │             │  │             │  │ (§7.4)      │  │ (§7.5)      │ │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘ │
└─────────┼────────────────┼────────────────┼────────────────┼────────┘
          │                │                │                │
┌─────────▼────────────────▼────────────────▼────────────────▼────────┐
│              PACE Session Layer (§3, §4, §5)                        │
│     Session Mgmt │ Identity │ Authorization │ Multi-Modal Channels   │
└─────────────────────────────────┬───────────────────────────────────┘
                                  │
┌─────────────────────────────────▼───────────────────────────────────┐
│              MOQT Transport Binding (§6)                            │
│   Connection │ Track Org │ Serialization │ Priority │ Operations    │
└─────────────────────────────────┬───────────────────────────────────┘
                                  │
┌─────────────────────────────────▼───────────────────────────────────┐
│                    QUIC / WebTransport                               │
│     Encryption (TLS 1.3) │ Multiplexing │ Connection Migration      │
└─────────────────────────────────────────────────────────────────────┘
~~~
{: #figure-binding-arch title="Protocol Binding Architecture"}

Each protocol binding defines:

* **Protocol Identifier**: Unique string (e.g., "a2a", "mcp") used
  in the namespace category field
* **Version**: Protocol version supported by the binding
* **Namespace Pattern**: How protocol operations map to PACE
  namespace categories and track names
* **Message Serialization**: Encoding of protocol messages within
  MOQT object payloads
* **Operation Mapping**: Protocol operations to MOQT primitives
* **Priority Mapping**: Protocol message types to PACE priority tiers

Different protocols use distinct namespace categories within PACE
sessions:

| Protocol | Namespace Category | Example Full Namespace | Example Track Name |
|----------|-------------------|------------------------|-------------------|
| A2A | `a2a/{subcategory}` | `pace/s1/agent-a/a2a/task` | `t1` |
| MCP | `mcp/{subcategory}` | `pace/s1/fs-server/mcp/tools` | `read` |
| AutoGen | `autogen/{subcategory}` | `pace/s1/rt1/autogen/agent` | `msg` |
| Generic | `ext/{proto}/{subcategory}` | `pace/s1/custom/ext/myproto/rpc` | `call` |

## A2A Binding {#a2a-binding}

The Agent-to-Agent Protocol {{A2A}} binding maps A2A's task delegation
and collaboration semantics to MOQT primitives. This binding operates
within PACE sessions using the `a2a/` category prefix.

### Namespace Structure

A2A uses the following namespace hierarchy within an PACE session:

~~~
pace/{session-id}/{agent-id}/a2a/{subcategory} -- {track-name}
~~~

Where `subcategory` identifies the A2A message class:

| Subcategory | Purpose | Track Name Pattern |
|-------------|---------|-------------------|
| request | Outbound requests | `{request-id}` |
| response | Request responses | `{request-id}` |
| stream | Streaming operations | `{request-id}` |
| task | Task lifecycle | `{task-id}` |
| notify | Push notifications | `{notification-type}` |
| discovery | Agent cards | `agent-card` |

### A2A Operation Mapping {#a2a-operation-mapping}

The following table maps A2A v0.3.0 operations to MOQT primitives.
The Generic Pattern column references patterns from {{operation-mapping}}.

| A2A Operation | MOQT Mechanism | Track Pattern | Generic Pattern |
|---------------|----------------|---------------|-----------------|
| `SendMessage` | PUBLISH + OBJECT | `a2a/request -- {req-id}` | One-shot request |
| `SendStreamingMessage` | PUBLISH + multiple OBJECTs | `a2a/stream -- {req-id}` | Streaming request |
| `GetTask` | SUBSCRIBE + OBJECT fetch | `a2a/task -- {task-id}` | Resource fetch |
| `ListTasks` | SUBSCRIBE_NAMESPACE | `a2a/task` | Resource listing |
| `CancelTask` | OBJECT on control track | `ctrl/cancel -- {task-id}` | Cancellation |
| `SubscribeToTask` | SUBSCRIBE (ongoing) | `a2a/task -- {task-id}` | Subscription |
| `GetExtendedAgentCard` | SUBSCRIBE + OBJECT | `discovery -- agent-card` | Resource fetch |
| `SetPushNotificationConfig` | PUBLISH + OBJECT | `a2a/notify -- config` | One-shot request |
| `GetPushNotificationConfig` | SUBSCRIBE + OBJECT | `a2a/notify -- config` | Resource fetch |

### Message Format

A2A messages are serialized as JSON-RPC 2.0 payloads within MOQT objects.
The binding preserves A2A's native message format without transformation:

~~~
MOQT Object Payload for A2A:

┌─────────────────────────────────────────────────────┐
│  PACE Envelope (version=0x01, flags=0x00)           │
├─────────────────────────────────────────────────────┤
│  {                                                  │
│    "jsonrpc": "2.0",                                │
│    "method": "message/send",                        │
│    "params": {                                      │
│      "message": {                                   │
│        "role": "user",                              │
│        "parts": [                                   │
│          {"kind": "text", "text": "Hello agent"}    │
│        ]                                            │
│      }                                              │
│    },                                               │
│    "id": "req-001"                                  │
│  }                                                  │
└─────────────────────────────────────────────────────┘
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
MOQT groups and objects following the streaming pattern in {{streaming}}.

A2A defines two streaming event types:

TaskStatusUpdateEvent:
: Published when task state changes. Contains task ID, current state
  (queued, running, completed, failed, canceled), and optional message.

TaskArtifactUpdateEvent:
: Published when task produces output. Contains artifact data (text,
  files, structured data) with incremental or complete delivery.

The mapping to MOQT objects:

* Each streaming response creates a new MOQT group
* Incremental updates are individual objects within the group
* TaskStatusUpdateEvent and TaskArtifactUpdateEvent map to objects
* Groups represent execution phases (initialization, progress, completion)

### A2A Agent Card with MOQT Extension {#a2a-agent-card}

Per A2A v0.3.0, each agent publishes an Agent Card containing identity,
capabilities, and supported operations. When operating over PACE, the
card includes a `moqt` extension block providing MOQT-specific
connectivity information:

~~~json
{
  "name": "research-assistant",
  "description": "Specialized research and analysis agent",
  "url": "https://example.com/agents/research",
  "protocolVersion": "0.3.0",
  "capabilities": {
    "streaming": true,
    "pushNotifications": true,
    "stateTransitionHistory": true
  },
  "skills": [
    {
      "id": "web-research",
      "name": "Web Research",
      "description": "Search and summarize web content"
    },
    {
      "id": "data-analysis",
      "name": "Data Analysis",
      "description": "Analyze structured datasets"
    }
  ],
  "authentication": {
    "schemes": ["bearer", "oauth2"],
    "credentials": [
      {
        "type": "oauth2",
        "authorizationUrl": "https://auth.example.com/authorize",
        "tokenUrl": "https://auth.example.com/token",
        "scopes": ["agent:invoke", "task:read"]
      }
    ]
  },
  "moqt": {
    "relayEndpoint": "moqt://relay.example.com:4443",
    "webTransportEndpoint": "https://relay.example.com:4443/moqt",
    "namespace": "pace/session-123/research-assistant",
    "supportedExtensions": ["pace-v1"],
    "maxConcurrentSubscriptions": 100,
    "cacheTTL": 300
  },
  "signature": "base64-encoded-ed25519-signature"
}
~~~

The `moqt` extension fields:

* `relayEndpoint`: Native QUIC endpoint for the MOQT relay
* `webTransportEndpoint`: WebTransport endpoint (alternative connectivity)
* `namespace`: Agent's PACE namespace prefix
* `supportedExtensions`: MOQT/PACE extensions supported
* `maxConcurrentSubscriptions`: Maximum subscriptions the agent handles
* `cacheTTL`: Recommended cache duration for the agent card (seconds)

## MCP Binding {#mcp-binding}

The Model Context Protocol {{MCP}} can be transported over PACE to
enable tool and resource access for agents. The complete specification
for MCP over MOQT is defined in {{MCP-MOQT}}.

### Namespace Structure

MCP uses the `mcp/` category prefix within PACE sessions:

~~~
pace/{session-id}/{server-id}/mcp/{subcategory} -- {track-name}
~~~

| Subcategory | Purpose | Track Name Pattern |
|-------------|---------|-------------------|
| control | Session/capability mgmt | `initialize`, `capabilities` |
| tools | Tool invocations | `{tool-name}` |
| resources | Resource access | `{resource-uri}` |
| prompts | Prompt templates | `{prompt-name}` |
| notifications | Async events | `{event-type}` |

### MCP Operation Mapping

| MCP Operation | MOQT Mechanism | Track Pattern |
|---------------|----------------|---------------|
| `initialize` | PUBLISH + OBJECT | `mcp/control -- initialize` |
| `tools/list` | SUBSCRIBE_NAMESPACE | `mcp/tools` |
| `tools/call` | PUBLISH + OBJECT (req/resp) | `mcp/tools -- {tool-name}` |
| `resources/list` | SUBSCRIBE_NAMESPACE | `mcp/resources` |
| `resources/read` | SUBSCRIBE + OBJECT | `mcp/resources -- {uri}` |
| `resources/subscribe` | SUBSCRIBE (ongoing) | `mcp/resources -- {uri}` |
| `prompts/list` | SUBSCRIBE_NAMESPACE | `mcp/prompts` |
| `prompts/get` | SUBSCRIBE + OBJECT | `mcp/prompts -- {name}` |
| `notifications/*` | PUBLISH to subscriber | `mcp/notifications -- {type}` |

### MCP Priority Mapping

| MCP Message Type | MOQT Priority Range |
|------------------|---------------------|
| Cancellation | 0-31 |
| Tool call response | 32-63 |
| Tool call request | 64-95 |
| Resource updates | 96-127 |
| Capability exchange | 128-159 |
| Notifications | 160-191 |
| Bulk resource fetch | 192-255 |

### Agent Skills over MOQT

{{MCP-MOQT}} defines an Agent Skills architecture (Section 6) that
extends AI capabilities beyond atomic tool operations. Skills provide
composed instructions for complex tasks and use progressive loading
(metadata, instructions, resources) that aligns naturally with MOQT's
object-based delivery, enabling efficient bandwidth utilization and
aggressive caching. The specification also describes relay support
(Section 5) for scalable MCP deployments, including subscription
aggregation where multiple client subscriptions are consolidated into
single upstream requests, and content caching strategies optimized for
AI workflows.

## AutoGen Binding {#autogen-binding}

AutoGen {{AutoGen}} is a multi-agent conversation framework that enables
complex LLM applications through agent collaboration. This binding
defines how AutoGen's conversation patterns map to MOQT within PACE
sessions.

### Namespace Structure

AutoGen uses the `autogen/` category prefix:

~~~
pace/{session-id}/{runtime-id}/autogen/{subcategory} -- {track-name}
~~~

Where:

* `session-id`: PACE session identifier
* `runtime-id`: AutoGen runtime instance identifier
* `subcategory`: Message class within the AutoGen binding

| Subcategory | Purpose | Track Name Pattern |
|-------------|---------|-------------------|
| message | Inter-agent messages | `{conversation-id}` |
| control | Runtime control | `{command}` |
| state | Agent state sync | `{state-key}` |
| result | Final outputs | `{task-id}` |

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
: Hierarchical namespaces enable nested conversations:
  `autogen/{session}/runtime-1/outer-agent/inner-runtime/inner-agent`

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

This binding provides a minimal baseline for custom agent protocols
that use JSON-RPC 2.0 messaging. It serves as an extensible foundation
for protocols not covered by specific bindings.

### Namespace Structure

Generic protocols use the `ext/` category prefix with their protocol
identifier:

~~~
pace/{session-id}/{agent-id}/ext/{protocol-name}/{subcategory} -- {track-name}
~~~

Where:

* `protocol-name`: Custom protocol identifier
* `subcategory`: Protocol-defined message class

### Track Categories

| Category | Purpose | Track Name Pattern |
|----------|---------|-------------------|
| rpc | Request/response | `{request-id}` |
| stream | Streaming data | `{stream-id}` |
| event | Async events | `{event-type}` |

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

Custom protocols extend this binding by:

1. Defining additional track subcategories
2. Specifying custom message schemas within the JSON-RPC params
3. Registering protocol-specific priorities
4. Adding custom metadata in MOQT extension headers

Implementations SHOULD document their extensions and MAY register
them in the IANA PACE Protocol Binding Registry.

## Multi-Agent Orchestration Patterns {#orchestration}

The binding layer supports common multi-agent coordination patterns.
Each pattern leverages MOQT's pub/sub and relay capabilities:

### Sequential Orchestration

Agents execute tasks in sequence, each passing results to the next:

~~~
Sequential Pattern:

Agent A ──result──▶ Agent B ──result──▶ Agent C
  │                    │                    │
  └─ publish to ──────▶└─ subscribe + ─────▶└─ subscribe +
     B's request         publish to           publish to
     track               C's request          result track
                         track
~~~

Each agent subscribes to its predecessor's response track and publishes
to the next agent's request track. MOQT groups track pipeline stages.

### Concurrent (Broadcast) Pattern

A coordinator distributes work to multiple agents simultaneously:

~~~
Concurrent Pattern:

                 ┌──▶ Agent B (specialist)
                 │       │
Coordinator ─────┼──▶ Agent C (specialist)
  (publish)      │       │
                 └──▶ Agent D (specialist)
                         │
                 ◀── all subscribe to ───┘
                     coordinator's
                     result aggregation track
~~~

The coordinator publishes a single request object; MOQT relay fan-out
delivers it to all subscribing specialists. Results are published back
to a shared aggregation track.

### Handoff Pattern

An agent transfers an active task to another agent:

~~~
Handoff Pattern:

Agent A ══task══▶ [publishes HANDOFF on ctrl track]
                       │
                       ▼
               Agent B subscribes to task track,
               receives cached context from relay,
               continues execution
~~~

The handoff leverages MOQT's relay caching — Agent B receives the full
task context (prior groups) upon subscribing, enabling seamless
continuation without explicit state transfer.

### Hierarchical Teams

See {{topologies}} for topology description. In the binding layer,
hierarchical teams use nested PACE sessions where each coordinator
maintains a parent session and creates child sessions for sub-task
delegation. Delegation chains ({{identity-discovery}}) ensure
authorization propagates correctly through the hierarchy.

# Benefits of MOQT for Agent Communication {#benefits}

MOQT provides significant advantages over traditional agent transports,
particularly for real-time collaboration and large-scale deployments.

| Feature | HTTP/JSON-RPC | gRPC | REST/SSE | MOQT (PACE) |
|---------|---------------|------|----------|--------------|
| Pub/Sub Native | No | Limited | No | Yes |
| Multi-party Broadcast | Polling | N/A | Fan-out only | Native fan-out |
| Relay/CDN Support | Separate infra | N/A | CDN possible | Built-in |
| Priority QoS | Application layer | Per-stream | None | Per-object (0-255) |
| Connection Migration | No | Limited | No | QUIC native |
| Late Join Support | N/A | N/A | N/A | Group-based |
| Streaming Granularity | Message-level | Stream | SSE events | Object/Group |
| Discovery Mechanism | Well-known URI | Service registry | Well-known URI | SUBSCRIBE_NAMESPACE |
| Session Recovery | Re-establish | Reconnect | Reconnect | Relay cache + resume |
| Multi-Modal Concurrent | Multiple conns | Multiple streams | Multiple conns | Single session |

MOQT enables real-time agent communication through low-latency
streaming, priority-based message delivery, and built-in flow control
that prevents overload during high-volume interactions.

The publish/subscribe model provides scalability through one-to-many
broadcasts, dynamic in-band discovery via SUBSCRIBE_NAMESPACE, and
relay-based distribution that prevents connection explosion in large
mesh networks.

MOQT delivers reliability and resilience via QUIC connection migration,
relay caching for recovery from transient disconnections, session
suspension/resumption, and graceful degradation under load.

# Scalability and Reliability {#scalability}

## Relay Network Architecture

PACE inherits MOQT's relay architecture for geographic distribution
and load management:

~~~
Hierarchical Relay Network:

                   ┌─────────────────┐
                   │  Global Relay   │
                   │  (Federation)   │
                   └────────┬────────┘
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
   ┌──────▼──────┐   ┌──────▼──────┐   ┌──────▼──────┐
   │ Region A    │   │ Region B    │   │ Region C    │
   │ Relay       │   │ Relay       │   │ Relay       │
   └──────┬──────┘   └──────┬──────┘   └──────┬──────┘
          │                 │                 │
    ┌─────┴─────┐     ┌─────┴─────┐     ┌─────┴─────┐
    │           │     │           │     │           │
  Agent A    Agent B Agent C   Agent D Agent E   Agent F
~~~
{: #figure-relay-network title="Hierarchical Relay Network"}

Properties of the relay network:

* **Subscription Aggregation**: Multiple subscribers to the same track
  result in a single upstream subscription, reducing origin load
* **Geographic Locality**: Edge relays cache content close to
  subscribers, minimizing round-trip latency
* **Load Distribution**: Hierarchical structure prevents hotspots
  and single points of failure
* **Fault Isolation**: Relay failures are localized; other paths
  continue operating

## Caching Strategy

MOQT relays implement tiered caching optimized for agent communication:

| Cache Tier | TTL | Content |
|------------|-----|---------|
| Hot | Seconds | Active operation responses, real-time state |
| Warm | Minutes | Agent capability cards, session metadata |
| Cold | Hours | Historical context, audit logs |

Caching enables:

* Late-joining participants receive current session state
* Recovery from transient disconnections without peer retransmission
* Reduced load on agent endpoints through relay-served responses
* Efficient multipoint distribution of shared context

## Failure Modes and Recovery

| Failure | Detection | Recovery |
|---------|-----------|----------|
| Agent network loss | QUIC idle timeout | Connection migration, session resume |
| Relay failure | Subscription timeout | Failover to alternate relay |
| Agent crash | Session heartbeat miss | Session suspended, await resume |
| Prolonged outage | Session timeout | Session closed, state checkpointed |

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

MOQT relays are trusted for routing but NOT for content inspection.
Relay operators:

* MUST NOT inspect or modify message payloads
* MUST enforce namespace-level access control
* MUST implement rate limiting and abuse prevention
* MAY cache objects for operational efficiency
* MUST NOT retain cached content beyond operational necessity

For deployments requiring end-to-end confidentiality even from relay
operators, agents MAY implement payload encryption above the PACE layer.

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

| Protocol ID | Version | Namespace Pattern | Reference |
|-------------|---------|-------------------|-----------|
| a2a | 0.3.0 | `pace/{s}/{a}/a2a/` | This document |
| mcp | 2025-06-18 | `pace/{s}/{a}/mcp/` | This document |
| autogen | 0.4 | `pace/{s}/{a}/autogen/` | This document |
| (generic) | - | `pace/{s}/{a}/ext/{proto}/` | This document |

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

# Acknowledgments

TODO
