---
title: "PACE: Protocol for Agent Communication Exchange"
abbrev: "PACE"
category: std

docname: draft-nandakumar-agentproto-pace-latest
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
 - dialog management
 - real-time communication

venue:
  group: "Agent Communication Protocols"
  type: "Working Group"
  mail: "agentproto@ietf.org"
  arch: "https://mailarchive.ietf.org/arch/browse/agentproto/"
  github: "suhasHere/draft-nandakumar-agentproto-pace"
  latest: "https://suhasHere.github.io/draft-nandakumar-agentproto-pace/draft-nandakumar-agentproto-pace.html"

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
  RFC8259:
  RFC9562:
  MoQ-TRANSPORT:
    title: "Media over QUIC Transport"
    date: 2026-10
    author:
    - ins: S. Nandakumar
    - ins: V. Vasiliev
    - ins: I. Swett
      role: editor
    - ins: A. Frindell
      role: editor
    seriesinfo:
      Internet-Draft: draft-ietf-moq-transport-22
    target: https://datatracker.ietf.org/doc/draft-ietf-moq-transport/

informative:
  ARCH: I-D.manyfolks-agentproto-arch
  QMUX: I-D.ietf-quic-qmux
  WIMSE-CREDS: I-D.ietf-wimse-workload-creds
  RFC6749:
  RFC7519:
  RFC8693:
  RFC9635:
  RFC7540:
  RFC9110:
  RFC9297:
  RFC9449:
  RFC9576:
  RFC9901:
  POPPY:
    title: "Personal Agent Protocol (Poppy) Specification"
    date: 2026
    author:
    - org: Sierra
    - org: Meta
    seriesinfo:
      Version: Draft 0.3
    target: https://personalagentprotocol.org/docs/0.3/spec
  A2A:
    title: "Agent-to-Agent Protocol Specification"
    date: 2025
    author:
    - org: Linux Foundation
    seriesinfo:
      Version: "1.0"
    target: https://a2a-protocol.org/latest/
  MCP:
    title: "Model Context Protocol Specification"
    date: 2026-07
    author:
    - org: Linux Foundation
    seriesinfo:
      Version: 2026-07-28
    target: https://modelcontextprotocol.io/specification/2026-07-28
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
    title: "Authorization scheme for MOQT using Common Access Tokens"
    date: 2026
    author:
    - ins: W. Law
    - ins: C. Lemmons
    - ins: G. Simon
    - ins: S. Nandakumar
    seriesinfo:
      Internet-Draft: draft-ietf-moq-c4m-01
    target: https://datatracker.ietf.org/doc/draft-ietf-moq-c4m/
  MCP-MOQT:
    title: "Model Context Protocol and Agent Skills over Media over QUIC Transport"
    date: 2026
    author:
    - ins: C. Jennings
    - ins: I. Swett
    - ins: J. Rosenberg
    - ins: S. Nandakumar
    seriesinfo:
      Internet-Draft: draft-jennings-agentproto-mcp-over-moqt
    target: https://datatracker.ietf.org/doc/draft-jennings-agentproto-mcp-over-moqt/
  STIVERS:
    title: "Universals and cultural variation in turn-taking in conversation"
    date: 2009-06
    author:
    - ins: T. Stivers
    - ins: N. J. Enfield
    - ins: P. Brown
    - ins: C. Englert
    - ins: M. Hayashi
    - ins: T. Heinemann
    - ins: G. Hoymann
    - ins: F. Rossano
    - ins: J. P. de Ruiter
    - ins: K.-E. Yoon
    - ins: S. C. Levinson
    seriesinfo:
      DOI: 10.1073/pnas.0903616106
    refcontent: "Proceedings of the National Academy of Sciences, vol. 106, no. 26, pp. 10587-10592"
  SD-CARD:
    title: "Agent SD-Card: Selective Disclosure of Agent Metadata for Discovery and Authentication"
    date: 2026-10
    author:
    - ins: S. Nandakumar
    - ins: C. Jennings
    seriesinfo:
      Internet-Draft: draft-nandakumar-agent-sd-card-00
    target: https://datatracker.ietf.org/doc/draft-nandakumar-agent-sd-card/

--- abstract

This document defines the Protocol for Agent Communication Exchange
(PACE), an agentic dialog management protocol with a binding to Media
over QUIC Transport (MOQT). A dialog is the correlated sequence of
interactions between two or more participants over the course of a
task. PACE defines a transport-independent dialog context and
control operations to establish, modify, and terminate
dialogs and to revoke propagation relationships. It specifies how that
context stays coherent across intermediaries, trust boundaries,
modality changes, and interruptions, and how it is carried over MOQT.
PACE does not interpret or define dialog content. Over MOQT, a dialog can
combine text, audio, video, and request/response exchanges in
point-to-point, point-to-multipoint, and multi-party topologies.
Application-layer agent protocols such as A2A, MCP, and AutoGen keep
their own message formats and carry the dialog context through
their own extension points.

--- middle

# Introduction

AI agents are autonomous software systems that work with users, other
agents, and tools to complete tasks. The exchanges between them form
dialogs. A dialog is the correlated
sequence of interactions between two or more participants over the
course of a task. For dialogs to work across platforms and vendors,
participants need a common way to correlate a dialog and maintain its
lifecycle across multiple hops, intermediaries, trust boundaries, and
changes of modality or network attachment, without sharing the
content of the dialog itself.

This document defines the Protocol for Agent Communication Exchange
(PACE). PACE has two parts:

* A transport-independent agentic dialog management protocol
  ({{dialog-management}}): the dialog context, the control operations
  that manage its lifecycle, and the rules participants and
  intermediaries follow when propagating it.
* A binding of that protocol to Media over QUIC Transport (MOQT)
  {{MoQ-TRANSPORT}} ({{moqt-binding}}, {{dialog-over-moqt}}), which
  carries the dialog context on MOQT tracks and uses MOQT relays for
  fan-out, prioritization, and multiplexing of dialog control
  alongside text, audio, video, and request/response exchanges.

In terms of the Agent Communication Protocol architecture {{ARCH}}, the
first part realizes the Agentic Dialog Management block
({{Section 6.1 of ARCH}}), and the second is the MOQT profile corresponding
to {{Section 9.1 of ARCH}}.

The dialog context consists of identifiers and lifecycle state only.
Content exchanged with AI models, such as conversation memory,
retrieved documents, or prompts, is not part of it.
The content is opaque to PACE, the MOQT binding carries it on content
tracks without interpreting it. PACE
does not replace application-layer agent protocols. A2A, MCP, AutoGen, and
similar protocols keep their native messages and carry the dialog
context through their own extension points ({{protocol-bindings}}).

## Scope and Goals {#scope}

Agent interactions are increasingly live dialogs rather than one-shot
requests. A user speaks while an agent answers, cuts in, and expects
the agent to stop. Voice and video run alongside chat, streaming model
output, and tool calls. Several agents and people work on the same
task, and the task can outlast a single connection or network. In
natural spoken conversation, people take turns within a few hundred
milliseconds {{STIVERS}}, so an interruption has to take effect ahead of output
that is already queued. PACE is designed for these dialogs.

PACE addresses the following goals.

* Dialog correlation: A dialog identifier that stays stable across hops,
  intermediaries, trust boundaries, modality changes, and time. Defined
  by the dialog context: identifier, generation, state, controller, and
  participants ({{dialog-context}}).
* Multi-modal exchange: Real-time media, chat, streaming model output,
  and request/response operations in one dialog. Each modality keeps its
  own latency and reliability, and none of them delays the others, even
  when they share one transport session ({{data-exchange}}).
* Multi-party exchange: Point-to-point, point-to-multipoint, and
  multi-party dialogs among agents and people. Relays fan out each
  message, so a sender publishes once however many participants there
  are, and late joiners catch up from relay caches ({{topologies}}).
* Low-latency interaction: Dialog control, including interruption and
  cancellation, takes effect within the latency of natural conversation
  and ahead of queued content, so that agents can hold an interactive
  voice conversation ({{data-exchange}}).
* Dialog lifecycle: Opening, updating, and terminating dialogs, and
  revoking propagation relationships, with the controller as the single
  authoritative source of state ({{lifecycle}}).
* Resilience: Recovery from path and intermediary failures, resumption
  after interruption, and defined behavior when a participant or the
  controller is unreachable ({{propagation}}, {{dialog-recovery}}).
* Transport independence: A dialog model that any transport can carry.
  This document specifies a MOQT binding: namespaces, tracks, operation
  mapping, and delivery ({{moqt-binding}}).
* Application protocol reuse: MCP, the Personal Agent Protocol, AutoGen,
  and A2A keep their native messages and carry the dialog context
  ({{protocol-bindings}}).
* Identity and authorization reuse: Agent identity separate from user
  identity, delegated authorization, and selective disclosure, without
  mandating a token format ({{identity-discovery}}, {{authorization}}).
* Privacy: Mitigations for linkage through persistent dialog and
  participant identifiers ({{privacy}}).

PACE does not define trust frameworks,
authorization protocols, or audit data structures; deployments use
existing mechanisms, and auditing systems can use dialog identifiers.
Dialog content, model behavior, planning, and task semantics are also
out of scope.

## Requirements Language

{::boilerplate bcp14-tagged}

## Terminology {#terminology}

Dialog:
: The correlated sequence of interactions between two or more
  participants over the course of a task. A dialog can outlast any
  single message exchange, MOQT session, or transport connection. A
  two-party dialog is an agentic dialog {{ARCH}}, which
  composes larger topologies by cascading two-party dialogs; PACE
  supports both cascaded and multi-party dialogs ({{topologies}}).

Dialog context:
: The identifiers and lifecycle state needed to correlate and
  maintain a dialog ({{dialog-context}}). The dialog context does not
  include content exchanged with AI models, such as conversation
  memory, retrieved documents, prompts, or media payloads. It
  corresponds to the meta-data of the {{ARCH}} dialog context. The
  {{ARCH}} log is the dialog's content, which a binding carries; in the
  MOQT binding, it is the sequence of objects on the dialog's content
  tracks ({{track-organization}}).

Dialog identifier (dialog-id):
: A UUID that names a dialog for its whole lifetime.

Participant:
: A user-facing client, agent, tool, or service that takes part in a
  dialog and processes its dialog context. Each participant has a
  participant identifier that is unique within the dialog. In the
  MOQT binding, the participant identifier is the agent-id in the
  participant's namespace ({{namespace}}). A participant plays the
  principal or agent role of {{ARCH}}; the controller is usually the
  principal's client.

Controller:
: The participant that opened the dialog. The controller is the
  authoritative source of the dialog context and the only participant
  that changes the participant set, expiration, generation, or
  terminal state.

Intermediary:
: An entity that forwards dialog context between participants without
  being the source of it. A MOQT relay that forwards PACE tracks is an
  intermediary, and so is a gateway that transforms one modality into
  another.

Propagation relationship:
: The authorization and forwarding relationship that allows a
  participant or intermediary to receive or forward a dialog's
  context. PACE signals the creation and revocation of such
  relationships; the deployment's authorization mechanism enforces
  them.

MOQT session:
: A transport-level session established with MOQT SETUP. A MOQT
  session is not a dialog: one dialog can span several MOQT sessions,
  and one MOQT session can carry several dialogs.

# Architecture Overview

The PACE architecture layers as follows:

~~~
┌─────────────────────────────────────────────────────────┐
│  Application Protocols (A2A, MCP, AutoGen, Poppy, ...)  │
├─────────────────────────────────────────────────────────┤
│  PACE Dialog Management: dialog-id │ lifecycle │        │
│  propagation                                            │
├─────────────────────────────────────────────────────────┤
│  PACE MOQT Binding: namespaces │ control tracks │       │
│  media and operation tracks │ priority                  │
├─────────────────────────────────────────────────────────┤
│  MOQT: Pub/Sub │ Namespace Routing │ Relay Caching      │
├─────────────────────────────────────────────────────────┤
│  QUIC / WebTransport: TLS 1.3 │ Mux │ Migration         │
└─────────────────────────────────────────────────────────┘
~~~
{: #figure-arch title="PACE Architecture"}

Identity, authentication, authorization, and encryption are building
blocks used across these layers. PACE integrates them
({{identity-discovery}}, {{authorization}}) but does not define new
ones.

## Transport Requirements {#transport-requirements}

Live dialogs ({{scope}}) place the following requirements on the
transport that carries them. They refine the transport aspects of
{{Section 8 of ARCH}} for live, multi-modal dialogs.

* Low latency: Each flow reaches participants within the latency its
  modality needs: under 100 ms for real-time media, and under a second
  for chat and streaming model output ({{data-exchange}}). A loss or a
  backlog on one flow does not add delay to another.
* Push delivery: Content, new participants, new flows, and new dialogs
  reach participants as soon as they are published, without polling.
* Interruption: Dialog control, such as an interruption or a
  cancellation, reaches its receiver ahead of content that is already
  queued. Real-time content that is too late to be useful is dropped
  instead of being delivered late.
* Concurrent flows: Real-time media, chat, streaming model output, tool
  calls, and bulk transfers share one dialog and one connection, each
  with its own priority and reliability.
* Fan-out: One message reaches every participant without the sender
  sending a copy to each. Participants that join late or reconnect can
  catch up.
* Continuity: A dialog survives connection migration, network changes,
  reconnection, and intermediaries.
* Scale and control: Dialogs scale through intermediaries across
  regions, and each intermediary enforces who may send and receive.

Request/response mechanisms might not meet these requirements. When a
dialog's flows share one ordered connection, a cancellation waits
behind output that has already been sent, and one lost packet stalls
every flow. Delivery to several participants, and learning about new
ones, are left to the application.

## Why MOQT?

This document specifies a MOQT binding for exchanging dialogs. Media
over QUIC Transport (MOQT) {{MoQ-TRANSPORT}} is a publish/subscribe
protocol over QUIC. It meets each requirement in
{{transport-requirements}} with a transport mechanism, so agent
protocols do not need to rebuild them.

* Low latency: Objects are sent as soon as they are produced, on QUIC
  streams or datagrams alike, and relays forward them as they arrive,
  without waiting for the rest of a group. Each track has its own
  streams, so a loss on one flow does not hold up the others. Datagrams
  are not retransmitted, so real-time media keeps flowing under
  congestion instead of waiting for lost data.
* Push delivery: Agents publish and subscribe directly, with no polling
  and no long-lived HTTP connections. Content reaches subscribers as
  soon as it is published. SUBSCRIBE_TRACKS on a namespace prefix
  delivers all current and future tracks under that prefix, so new
  dialogs and flows appear without a separate signaling channel. Output
  that arrives minutes or hours after its input reaches the subscriber
  without a webhook or a client-side HTTP server.
* Interruption: Publisher priority (per subgroup or datagram) and
  subscriber priority (per subscription) let dialog control overtake
  queued lower-priority data, so a cancellation reaches the agent ahead
  of output already in flight. Per-track delivery timeouts let the
  publisher mark time-sensitive objects: objects that miss the deadline,
  such as a voice frame whose playout window has passed, are dropped at
  the relay instead of wasting bandwidth and queue depth.
* Concurrent flows: One MOQT session carries sub-100ms media, sub-second
  chat, and best-effort bulk transfers at the same time, in one
  congestion control context. Objects can be delivered over QUIC
  datagrams, which suit real-time audio and video where lower latency
  matters more than retransmission, or over QUIC streams, which suit
  agent chat, operations, and bulk transfers that need ordered, reliable
  delivery.
* Fan-out: A single PUBLISH reaches every subscriber through the relay,
  so multi-agent collaboration does not need application-level broadcast
  code, and the publisher keeps no per-subscriber state. Relay caches
  let late-joining or reconnecting agents catch up without the publisher
  retransmitting.
* Continuity: QUIC provides connection migration (for example, from
  Wi-Fi to cellular) and 0-RTT resumption. A dialog is not tied to a
  MOQT session: one dialog can span several sessions ({{terminology}}).
  An agent namespace is not tied to a host either, so the principal and
  the agent can each move between hosts over a dialog's lifetime and a
  new client instance catches up from relay caches.
* Scale and control: Relays handle NAT traversal, load balancing, and
  fan-out without direct peer-to-peer connections, and they can be
  stacked hierarchically to spread load across regions without an
  all-to-all mesh. Namespace-level access control maps onto agent
  authorization scopes: the relay decides who may publish or subscribe
  to each namespace. QUIC provides TLS 1.3 for every hop.

Where UDP is blocked, the same MOQT binding can run over QMux
{{QMUX}}, which provides QUIC stream and datagram operations over TLS
over TCP. Agents keep one protocol stack instead of falling back to a
separate one, at the cost of TCP head-of-line blocking and reliable,
ordered datagrams.

# Agentic Dialog Management {#dialog-management}

This section defines the dialog context, its lifecycle, and the rules
for propagating it. The mapping of this protocol onto MOQT is defined
in {{moqt-binding}}.

## Dialog Context {#dialog-context}

A dialog context contains the following fields:

* `dialog_id`: A UUID version 4 {{RFC9562}}. The controller generates it
  when opening the dialog. It remains unchanged for the lifetime of the
  dialog, including when the dialog crosses an intermediary, changes
  modality, or resumes after a connection loss.
* `generation`: An unsigned integer identifying the current controller
  state. The initial generation is 0. The controller increments it by
  one for each committed change to the dialog context, including a
  change in a participant's state.
* `state`: One of `pending`, `active`, or `terminated`.
* `controller_id`: The participant identifier of the controller.
* `participants`: The set of participant identifiers in the dialog, each
  with a state: `invited`, `active`, `left`, `rejected`, or `revoked`.
* `expires_at`: An optional absolute time in RFC 3339 date-time format.
  When present, participants treat the dialog as terminated at that
  time.
* `parent_dialog_ids`: An optional list of dialog-ids, set by the
  controller in OPEN when the dialog is opened to carry out work
  delegated from another dialog. The first entry is the dialog that
  triggered this one, followed by that dialog's own parents, so the list
  traces the delegation chain back to the originating dialog ({{Section
  6.2.1 of ARCH}}). It does not change after OPEN.

The context is encoded as a JSON object:

~~~json
{
  "dialog_id": "550e8400-e29b-41d4-a716-446655440000",
  "generation": 0,
  "controller_id": "agent-a",
  "state": "pending",
  "participants": [
    {"participant_id": "agent-a", "state": "active"},
    {"participant_id": "agent-b", "state": "invited"}
  ],
  "expires_at": "2026-10-23T12:00:00Z"
}
~~~

The `expires_at` member is omitted when the dialog has no configured
expiration, and `parent_dialog_ids` is omitted when the dialog was not
opened from another dialog. A context snapshot MUST contain every other
member,
including participants whose states are `left`, `rejected`, or
`revoked`. A controller MUST NOT remove a participant from a later
snapshot; it changes that participant's state instead. The controller
MUST appear in the participant set with state `active`.

The identity of the principal on whose behalf a delegated dialog runs
travels in the `credentials` member as a delegation chain
({{delegation}}), not in the dialog context.

These identifiers are correlation values. They MUST NOT be treated as
credentials or bearer authorization. Knowing a parent dialog-id does
not grant access to the parent dialog. A participant identifier MUST NOT
encode personal or task information.

### Dialog Parameters {#dialog-parameters}

Dialog parameters are negotiated in the `parameters` member of OPEN,
ACCEPT, UPDATE, and JOIN_REQUEST ({{control-encoding}}). They describe
how the dialog is conducted and are not part of the dialog context:

* `dialog_type`: Short-lived (bounded duration) or long-lived
  (indefinite)
* `idle_timeout`: Maximum idle duration before the controller
  terminates the dialog
* `max_participants`: Maximum number of participants in the dialog
* `supported_modalities`: Data modalities the participant can handle
* `supported_protocols`: Application protocols offered (A2A, MCP, etc.)
* `content_encoding`: Compression applied to content payloads (for
  example, `gzip`); absent means none ({{message-serialization}})

### Dialog Lifetime {#dialog-lifetime}

Short-lived dialogs carry an `expires_at` in the dialog context and end
when it passes. Long-lived dialogs omit `expires_at` and continue
across idle periods and interruptions until the controller terminates
them. When `idle_timeout` is set and the dialog has been idle for that
long, with no content or control sent by any participant, the
controller SHOULD publish TERMINATE.

## Lifecycle and Control Operations {#lifecycle}

The dialog lifecycle has three states:

~~~
                  OPEN (controller, generation 0)
                                |
                                v
                         +-------------+
              UPDATE +-->|   PENDING   |------------------+
                     |   +-------------+                  |
                     |      |      |                      |
                     +------+      | UPDATE committing    | TERMINATE
                                   | an invitee's ACCEPT  | or expiry
                                   v                      v
                         +-------------+            +------------+
      UPDATE, REVOKE +-->|   ACTIVE    |----------->| TERMINATED |
                     |   +-------------+ TERMINATE  |  (final)   |
                     |      |            or expiry  +------------+
                     +------+

~~~
{: #figure-dialog-states title="Dialog State Machine"}

pending:
: The controller has opened the dialog, but no invitee has accepted.

active:
: At least one invitee has accepted, and the dialog has not been
  terminated or expired. The context can be modified with UPDATE and
  REVOKE.

terminated:
: The controller has terminated the dialog, or its expiration time
  has passed. This state is final.

Only the controller causes transitions. UPDATE, REVOKE and
TERMINATE each advance the generation by one. ACCEPT, REJECT,
JOIN_REQUEST and LEAVE are requests the controller commits with
UPDATE. Interruptions and cancellations do not change the state.

An interruption, such as a lost connection or relay failure, does not
change the dialog state. Participants recover the current context as
described in {{propagation}}. A participant's own state is tracked
separately from the dialog state: joining or leaving does not by itself
terminate the dialog. When the controller commits a LEAVE that leaves
it as the only active participant, it SHOULD publish TERMINATE. This
lets an agent that is not the controller end a two-party dialog.

The control operations below cover the lifecycle functions of
{{Section 6.1.2 of ARCH}}. Initiation is OPEN, and termination is
TERMINATE, expiry, or a LEAVE that ends a two-party dialog. Suspension
needs no operation: a dialog persists through idle periods with no
transport connection, and a binding can pause individual flows.
Resumption is STATE_REQUEST together with the binding's recovery of
missed content ({{dialog-recovery}} for MOQT), and cancellation is
CANCEL ({{cancellation}}).

PACE defines the following control operations:

| Operation | Sender | Generation | Effect |
|---|---|---|---|
| OPEN | Controller | 0 | Creates a pending dialog and identifies invitees. |
| ACCEPT | Participant or invitee | Current | Accepts an invitation or a parameter proposal. |
| REJECT | Participant or invitee | Current | Rejects an invitation or a parameter proposal. |
| UPDATE | Controller | Next | Replaces the participant set or expiration. |
| JOIN_REQUEST | Prospective participant | Latest known, or 0 | Requests admission to an existing dialog. |
| LEAVE | Participant | Current | Leaves the dialog. The controller records the participant as left. |
| REVOKE | Controller | Next | Revokes a participant's propagation relationship. |
| TERMINATE | Controller | Next | Ends the dialog. |
| CANCEL | Any participant | Current | Asks receivers to stop work started by the sender's earlier input ({{cancellation}}). |
| CANCEL_ACK | Any participant | Current | Reports the outcome of a CANCEL. |
| STATE_REQUEST | Participant | Current | Requests the current context after a gap or reconnection. |
| STATE | Controller | Current | Supplies a complete context snapshot. |
| ERROR | Any participant | Current | Reports that an operation was not applied, and why. |
{: #table-control-ops title="Control Operations"}

### Committing Participant Changes

Only the controller changes the dialog context. Other participants
send requests and responses, and the controller commits the result.

* OPEN includes at least one invitee.
* ACCEPT and REJECT answer a proposal from the controller, named by
  `in_reply_to`: an invitation in OPEN or UPDATE, or a parameter
  change carried in `parameters` on UPDATE. After the controller
  commits an invitee's answer, its state is `active` or `rejected`. A
  participant that rejects a parameter change remains in the dialog;
  the controller then withdraws the change in a later UPDATE or
  revokes the participant.
* JOIN_REQUEST does not add a participant. The controller admits the
  requester by sending UPDATE with the requester's state set to
  `invited`, or refuses it with ERROR `policy-rejected`.
* ACCEPT, REJECT, JOIN_REQUEST, and LEAVE do not modify the context by
  themselves. The controller commits each resulting change by
  publishing UPDATE with the complete context at the next generation.
* The dialog becomes `active` when the controller publishes such an
  UPDATE after at least one invitee has accepted.

### Revoking a Participant

REVOKE is controller-authoritative. It carries the complete context at
the next generation, sets the target participant's state to `revoked`,
and ends that participant's propagation relationship. A participant or
intermediary that receives REVOKE:

* MUST stop forwarding the dialog's context to the target.
* MUST cancel subscriptions that it holds only to propagate the dialog
  to the target.

### Cancellation {#cancellation}

A principal that interrupts an agent, a policy decision, or a failed
subtask can require work to stop at once. PACE carries cancellation as
a dialog control operation rather than relying on connection teardown,
so a binding can deliver it ahead of queued content. The MOQT binding
sends it on the `ctrl` track at critical priority ({{cancel-over-moqt}}).

CANCEL does not change the dialog context and does not end the dialog.
Its `scope` member selects the work to stop:

operation:
: A single operation the sender started, named in `target`.

subtree:
: All work the receivers carry out in delegated dialogs whose
  `parent_dialog_ids` include this dialog. A receiver that controls
  such a dialog sends CANCEL with scope `dialog` in it, so cancellation
  propagates down the delegation chain and dependent subtasks do not
  continue after the parent work is withdrawn.

dialog:
: All work the sender started in this dialog, together with its
  subtree.

A receiver applies CANCEL through the application protocol's own
cancellation where one exists, such as MCP `notifications/cancelled`
or A2A `CancelTask`, so the application sees its native cancel. CANCEL
is idempotent: a receiver that has already acted on a CANCEL reports
the same outcome again and does not repeat side effects.

Each receiver doing affected work answers with CANCEL_ACK, giving one
of these outcomes:

* `stopped`: the work stopped before completing.
* `completed`: the work had already completed.
* `irreversible`: the work stopped, but an action it took could not be
  rolled back.

### Generations and Ordering {#generations}

UPDATE, REVOKE, and TERMINATE carry the next generation and a complete
context, so a receiver replaces its state as a whole instead of merging
partial updates. Other operations carry the current generation
({{table-control-ops}}).

* The controller MUST serialize its state-changing operations and MUST
  NOT reuse a generation for different state.
* A receiver MUST reject a controller operation whose generation is
  lower than the latest generation it accepted, with ERROR
  `stale-generation`.
* If a receiver sees a generation greater than the next expected one,
  it MUST send STATE_REQUEST and MUST NOT infer the missing changes.
* A prospective participant does not yet track the dialog, so its
  JOIN_REQUEST carries the latest generation it knows, or 0. The
  controller does not reject a JOIN_REQUEST as stale.
* Receivers use the message identifier and generation to detect
  duplicates and stale messages. Reprocessing a duplicate operation
  MUST NOT repeat its side effects.

### Authorization and Errors

Before applying an operation, a participant MUST authenticate its
sender and check authorization using the deployment's mechanisms
({{authorization}}). A valid state-changing operation needs no separate
acknowledgment. An ERROR names the rejected message in `in_reply_to`
and gives one of the reasons below or in the rules above.

* A message that cannot be parsed, or that lacks a required member
  ({{control-encoding}}), is rejected with ERROR `malformed`.
* If authorization fails or cannot be determined, the participant MUST
  reject the operation with ERROR, giving `unauthorized` or
  `authorization-unavailable` as the reason, without revealing policy
  details.
* A participant that does not understand the control-message version
  or an operation MUST NOT reinterpret it. It responds with ERROR,
  giving `unsupported-version` or `unsupported-operation`.

### Termination and Expiry

TERMINATE is final.

* After TERMINATE, a receiver MUST reject later operations for the
  dialog, except a duplicate TERMINATE or a STATE needed to complete
  synchronization.
* Expiration has the same effect as TERMINATE. Each participant
  evaluates it locally from `expires_at`, and it does not create a new
  generation.
* A controller SHOULD publish TERMINATE before the expiration time when
  it can.
* Resuming a transport connection does not reopen a terminated or
  expired dialog.

## Propagation and Continuity {#propagation}

* Correlation across hops: An intermediary MUST preserve the dialog
  identifier, generation, and lifecycle operation when forwarding dialog
  context. It MUST NOT create a new dialog identifier or change the
  dialog state. This document defines no identifier-alias mechanism; a
  deployment that needs aliases requires a separate mechanism that
  securely correlates the alias with the original dialog.
* Trust boundaries: A participant forwarding dialog context into another
  trust domain does so only within a propagation relationship that the
  deployment's authorization mechanism permits. Authorization to forward
  or subscribe at the transport layer does not by itself make an entity
  a participant.
* Modality changes: Transforming a modality, such as converting audio to
  text, does not create a new dialog. Participants and intermediaries
  MUST keep the same dialog identifier and current lifecycle state
  across the transformation.
* Continuity over time: After a connection loss, a participant MAY
  reconnect, over a new transport session if necessary, using the
  existing dialog identifier. It MUST obtain the current context from
  the controller with STATE_REQUEST before acting on state that may have
  changed while it was disconnected. Recovering the dialog context does
  not imply that any application operation was delivered or completed,
  or that it is safe to retry.
* Unreachability: If the controller is unreachable, participants MUST
  suspend actions that depend on an unconfirmed context change. Each
  participant remains at the last generation it accepted until the
  controller is reachable again or the dialog expires. Participants MUST NOT create
  a replacement dialog solely because a path or intermediary failed. If
  an invitee or participant is unreachable, the controller MAY revoke it
  or let the dialog expire, according to deployment policy.

## Control Message Encoding {#control-encoding}

A PACE control message is a UTF-8 encoded JSON object {{RFC8259}}.
Every control message contains these members:

* `version`: The integer 1.
* `type`: One of the operations in {{lifecycle}}.
* `dialog_id`: The canonical textual form of the dialog's UUID.
* `generation`: A non-negative integer no greater than 2^53 - 1.
* `sender_id`: The sender's participant identifier.
* `message_id`: A UUID version 4 unique to this message.

Control messages also carry the following type-specific members:

* `context`: The complete dialog context, encoded as the JSON object
  defined in {{dialog-context}}.
* `in_reply_to`: The `message_id` of the OPEN or UPDATE being accepted
  or rejected, of the CANCEL being acknowledged, or of the message an
  ERROR rejects.
* `target_id`: The participant identifier whose propagation relationship
  is revoked.
* `scope`: The cancellation scope: `operation`, `subtree`, or `dialog`
  ({{cancellation}}).
* `target`: The operation to cancel when `scope` is `operation`. Its
  form is defined by the transport binding ({{cancel-over-moqt}}).
* `outcome`: One of `stopped`, `completed`, or `irreversible`.
* `last_accepted_generation`: The highest generation the sender has
  accepted from the controller, or -1 if it has accepted none.
* `reason`: One of `malformed`, `unsupported-version`,
  `unsupported-operation`, `stale-generation`, `unauthorized`,
  `authorization-unavailable`, or `policy-rejected`. These
  distinguish validation, authorization, and policy failures
  from transport failures, which MOQT reports separately ({{Section
  6.1.5 of ARCH}}).

Each type requires the members listed below:

| Type | Required type-specific members |
|---|---|
| OPEN | `context` |
| ACCEPT | `in_reply_to` |
| REJECT | `in_reply_to`; `reason` optional |
| UPDATE | `context` |
| JOIN_REQUEST | none |
| LEAVE | none |
| REVOKE | `target_id`, `context` |
| TERMINATE | `context` |
| STATE_REQUEST | `last_accepted_generation` |
| STATE | `context` |
| CANCEL | `scope`; `target` when `scope` is `operation` |
| CANCEL_ACK | `in_reply_to`, `outcome` |
| ERROR | `in_reply_to`, `reason` |

For OPEN, `context` has generation 0 and state `pending`, and carries
`parent_dialog_ids` when the dialog is delegated. For UPDATE,
REVOKE, and TERMINATE, `context` has the next generation, and a
TERMINATE context has state `terminated`. An UPDATE that adds a
participant sets that participant's state to `invited`; the
participant becomes `active` only after it accepts and the controller
publishes a later UPDATE.

Three optional members carry information that is not part of the dialog
context:

* `parameters`: On OPEN, ACCEPT, UPDATE, and JOIN_REQUEST, the dialog
  parameters being proposed or accepted, such as modalities and
  application protocols ({{dialog-parameters}}).
* `credentials`: On any message, an identity assertion or
  authorization proof in a format selected by the deployment
  ({{identity-formats}}). A participant
  refreshes its credentials before they expire by including new ones
  on a later message.
* `nonce`: On OPEN, ACCEPT, UPDATE, and JOIN_REQUEST, a fresh random
  value, with at least 128 bits of entropy and base64url-encoded, to
  which the recipient binds the presentation in its next
  `credentials` ({{key-binding}}).

JSON member order is insignificant. Receivers MUST ignore unrecognized
optional members, MUST reject an unrecognized `type`, and MUST reject
messages with missing required members, invalid member types, or an
unsupported version. Receivers MUST limit the size of a control message
to a locally configured maximum. A participant MUST NOT include
application content in a control message.

# MOQT Binding {#moqt-binding}

This section specifies how the dialog management protocol of
{{dialog-management}} is carried over MOQT.

## Namespace Organization {#namespace}

PACE uses MOQT's hierarchical namespace for routing, isolation, and
multiplexing. In MOQT, content is addressed by a Track Namespace (an
ordered set of up to 32 fields, compared as byte sequences
{{MoQ-TRANSPORT}}) together with a Track Name. PACE organizes
communication into three namespace scopes, described in the following
subsections.

### Agent Namespace

~~~
  ("pace", "agents", {agent-id}) -- {track}
~~~

This is an agent's persistent identity on the relay network. Each agent
publishes the following tracks:

* `"card"` — Agent Card containing capabilities, identity claims,
  authentication schemes, and MOQT connectivity information

The common prefix `("pace", "agents")` enables SUBSCRIBE_NAMESPACE-based
discovery of all agents on the network. Interested agents then issue
SUBSCRIBE_TRACKS on a discovered agent's prefix to receive all current
and future tracks published by that agent. See {{agent-discovery}} for
the complete discovery flow.

### Dialog Communication Namespace

~~~
  ("pace", "agents", {agent-id}, {dialog-id}) -- {track}
~~~

The dialog-id is the dialog identifier ({{dialog-context}}). The
controller mints it when it opens the dialog. Each participant
publishes its tracks for the dialog under its own agent namespace,
using the shared dialog-id; the agent-id is the participant identifier
used in the dialog context. Any peer that has already issued
SUBSCRIBE_TRACKS on an agent's prefix is notified of new dialog tracks
automatically, as PUBLISH messages forwarded by the relay.

Each participant in a dialog publishes the following tracks:

* `"ctrl"` — Dialog control messages ({{control-encoding}})
* `"chat"` — Chat messages and streaming LLM output
* `"audio"` — Real-time audio stream
* `"video"` — Real-time video stream
* `"progress"` — Progress output, such as token counts, elapsed time,
  and liveness, kept apart from the response
* `"ops/{req-id}"` — Request/response operations (one track per request)

Only the `ctrl` track carries the dialog context. The other tracks
carry dialog content and are outside the dialog context. In the terms
of {{Section 4.2.11 of ARCH}}, `chat`, `audio`, and `video` carry
response output, operation and protocol binding tracks carry
information output, and `progress` carries progress output.

Protocol bindings extend the dialog namespace with additional
namespace fields, so that multiple protocols can operate concurrently
within a single dialog without track name collisions:

~~~
("pace", "agents", {agent-id}, {dialog-id}, {proto}, {category}, ...)
    -- {id}
~~~

* `{proto}` is the protocol identifier of the binding: `"mcp"`,
  `"poppy"`, `"a2a"`, or `"ext"` followed by a further field naming
  another protocol ({{protocol-bindings}}).
* `{category}` is the operation or primitive type (e.g., `request`,
  `response`, `task` for A2A; `tools`, `resources`, `prompts` for MCP).
* `{id}`, the track name, is the request, task, tool or resource
  identifier. A binding MAY define further namespace fields between
  `{category}` and the track name.

For example, in a dialog whose dialog-id is
`550e8400-e29b-41d4-a716-446655440000` (written `D` below), the
following Full Track Names are used:

~~~
A2A: "agent-a" sends request "r1" (in a dialog with "agent-b")
  ("pace","agents","agent-a",D,"a2a","request") -- "r1"

A2A: "agent-b" publishes updates for task "t1"
  ("pace","agents","agent-b",D,"a2a","task") -- "t1"

MCP: client "agent-a" calls tool "read_file" on "fs-server"
  ("pace","agents","agent-a",D,"mcp","tools","read_file")
      -- "request"

MCP: "fs-server" publishes the result of that call
  ("pace","agents","fs-server",D,"mcp","tools","read_file")
      -- "response"
~~~

The MCP tracks are the MCP over MOQT tracks
`(mcp, {session-id}, tools, {tool-name}) -- request` and
`-- response` {{MCP-MOQT}}, re-rooted under each publisher's PACE
namespace ({{mcp-binding}}).

See {{example-workflows}} for concrete examples of agent-to-agent,
agent-to-tool, and multi-agent collaboration workflows.


### Dialog Discovery Namespace {#dialog-discovery}

~~~
  ("pace", "discovery", "dialogs", {agent-id}) -- {dialog-id}
  ("pace", "discovery", "joins", {agent-id}, {dialog-id})
      -- {joiner-id}
~~~

A controller advertises a dialog that others may join by publishing a
descriptor track under its `dialogs` namespace, with the dialog-id as
the track name. Each object on a descriptor track contains:

* `dialog_id` — The dialog identifier
* `controller` — The controller's agent-id
* `description` — Human-readable purpose of the dialog
* `participants` — List of agent-ids currently in the dialog
* `modalities` — Supported data modalities (text, audio, video, etc.)

An agent that accepts join requests, or dialogs opened by controllers
that are not discoverable ({{opening}}), issues SUBSCRIBE_TRACKS on
its `joins` namespace, `("pace","discovery","joins",{agent-id})`. A prospective participant
asks to join by publishing a track under that namespace, named by its
own agent-id. The controller treats the arrival of such a track as
a join request and accepts it to read the request. The relay has no
knowledge of dialogs or join requests: it handles the PUBLISH and its
objects like any other track, forwarding them to the controller by
namespace prefix match, and enforces only the deployment's
authorization for publishing under that namespace
({{authorization}}).

A join track is not a new message type. Like a `ctrl` track, it
carries control messages ({{control-encoding}}) as object payloads;
its first object is a JOIN_REQUEST, or an OPEN when a controller that
is not discoverable opens a dialog ({{opening}}). The common members already tell
the controller what it needs: `sender_id` is the joiner's agent-id
(equal to the track name), which locates the joiner's namespace
`("pace","agents",{sender_id})`, and `dialog_id` names the dialog
(equal to the `{dialog-id}` field). `parameters` carries the dialog
parameters the joiner proposes ({{dialog-parameters}}), and
`credentials` its identity assertion and any authorization proof.
The join track is only needed because the controller is not yet
subscribed to the joiner's own `ctrl` track; once admitted, the
joiner uses its `ctrl` track and ends the join track.

A descriptor is advisory: the controller's STATE remains
authoritative, and finding a dialog does not make an agent a
participant. Controllers SHOULD NOT advertise dialogs whose existence
is itself sensitive ({{privacy}}).

Discovery and joining proceed in four steps:

* Advertise: The controller publishes a descriptor track for each dialog
  it offers under its `dialogs` namespace. It also subscribes to every
  track under its `joins` namespace, because it does not know in advance
  who will ask to join.
* Find: A prospective participant browses
  `("pace","discovery","dialogs")` to learn which agents offer dialogs,
  then reads the descriptors of the agents it is interested in. The
  descriptor gives the dialog-id, the controller, and the modalities,
  which the participant uses to decide whether to join.
* Ask: The prospective participant publishes a join track under the
  controller's `joins` namespace. The controller's subscription delivers
  the JOIN_REQUEST to it through the relay, and the controller validates
  the credentials and decides whether to admit the participant.
* Admit: The controller subscribes to the joiner's agent namespace and
  invites the joiner with UPDATE on its `ctrl` track. The joiner answers
  with ACCEPT on its own `ctrl` track and ends its join track. The
  controller's next UPDATE marks the joiner `active`, and the other
  participants then subscribe to the joiner's dialog namespace.

A controller that declines does not invite the joiner. The joiner stops
waiting after a local timeout and ends its join track with PUBLISH_DONE.

## Transport Binding {#transport-binding}

### Connection Establishment {#connection-establishment}

Agents MUST establish either a native QUIC connection or a WebTransport
{{RFC9297}} session as defined in {{MoQ-TRANSPORT}}. For native QUIC
connections, agents MUST use the ALPN value "moqt". For WebTransport,
the protocol is negotiated using the "WT-Available-Protocols" mechanism
as specified in {{MoQ-TRANSPORT}}.

Upon establishing the MOQT session via the SETUP message exchange
defined in {{MoQ-TRANSPORT}}, an agent performs the bootstrap sequence
to make itself discoverable:

1. Announce: PUBLISH_NAMESPACE on `("pace", "agents", {agent-id})`
2. Publish Agent Card: PUBLISH on track `"card"` under its namespace
3. Discover peers: SUBSCRIBE_NAMESPACE on `("pace", "agents")` to
   learn about other agents on the network

See {{agent-discovery}} for the full discovery flow that follows
bootstrap.

### Track Organization {#track-organization}

Each agent publishes exclusively on its own tracks. Other agents
issue SUBSCRIBE_TRACKS on a peer's agent prefix to receive all tracks
published by that peer, including dialog tracks. The relay handles
fan-out to all subscribers via prefix matching. This per-agent
publishing model ensures clear ownership and enables relay caching.

Namespace structure and track names are defined in {{namespace}}.

### Message Serialization {#message-serialization}

Each PACE object payload is one protocol message, with no PACE
header: a control message ({{control-encoding}}) on `ctrl` and join
tracks, and the protocol's native message on binding tracks. The
track namespace identifies the protocol, and MOQT carries the length.

Payloads are uncompressed unless the participants agree on a
`content_encoding` dialog parameter ({{dialog-parameters}}). It
applies to binding tracks only, never to `ctrl` or join tracks.

## Dialog Operations over MOQT {#dialog-over-moqt}

This section specifies how the operations of {{dialog-management}} are
carried over MOQT. Each control message is one MOQT object on the
sender's `ctrl` track under
`("pace","agents",{agent-id},{dialog-id})`. MOQT control messages
(PUBLISH, SUBSCRIBE, their responses, PUBLISH_DONE) establish and end
the subscriptions that carry those objects. They are not dialog
operations: PUBLISH_OK accepts a MOQT subscription, not a dialog, and a
participant MUST NOT infer acceptance, rejection, or termination of a
dialog from a MOQT response or cancellation alone.

The `ctrl` track MUST use Subgroup Delivery Mode and MUST NOT use
Datagram Delivery Mode or a finite delivery timeout. A participant
publishes control objects in increasing Object ID order, and the
controller publishes state-changing operations in increasing
generation order. Because `ctrl` is a track of its own, a CANCEL,
ERROR, or TERMINATE is not lost or delayed when a content track fails
or falls behind.

### Opening a Dialog {#opening}

Prerequisite: both agents have already completed discovery Phase 2
({{agent-discovery}}) and issued SUBSCRIBE_TRACKS on each other's
agent prefix. The relay will then forward PUBLISH messages between
them by prefix match.

Agent A (controller) opens a dialog with Agent B (invitee) as follows:

1. A generates a dialog-id (UUID version 4).

2. A publishes OPEN on
   `("pace","agents","agent-a",{dialog-id}) -- "ctrl"`. The context
   lists A as `active` and B as `invited`; `parameters` carries the
   proposed dialog parameters ({{dialog-parameters}}) and
   `credentials` carries A's identity assertion.

3. The relay prefix-matches the new track against B's SUBSCRIBE_TRACKS
   on `("pace","agents","agent-a")` and forwards the PUBLISH to B.

4. B accepts the PUBLISH, which subscribes it to A's ctrl track. This
   accepts the MOQT subscription only. B reads OPEN and decides
   whether to join.

5. B publishes ACCEPT (or REJECT) on
   `("pace","agents","agent-b",{dialog-id}) -- "ctrl"`, with the
   accepted parameters and its own credentials.

6. The relay prefix-matches the new track against A's SUBSCRIBE_TRACKS
   on `("pace","agents","agent-b")` and forwards the PUBLISH to A.

7. A reads ACCEPT and publishes UPDATE at generation 1, with B marked
   `active` and the dialog state `active`.

8. The dialog is active. Both agents can publish further tracks under
   their dialog namespaces; the relay forwards each new PUBLISH to the
   peer through the existing prefix subscriptions.

A controller that is not discoverable, for example because it uses
pairwise identifiers ({{poppy-binding}}), cannot rely on the invitee
following its agent prefix. It still issues SUBSCRIBE_TRACKS on the
invitee's agent prefix, and opens through the invitee's `joins`
namespace ({{dialog-discovery}}): in step 2, it also publishes a track
`("pace","discovery","joins",{invitee-id},{dialog-id}) --
{controller-id}` whose first object is the same OPEN. When the invitee
receives that track, it issues SUBSCRIBE_TRACKS on the controller's
agent prefix, and the dialog continues from step 3.

Multi-party dialogs follow the same pattern: the controller invites
participants in OPEN or a later UPDATE, and each invitee responds on
its own `ctrl` track. A participant that discovers a dialog
({{dialog-discovery}}) asks to join with JOIN_REQUEST.

#### MOQT Setup Extensions {#moqt-setup-extensions}

MOQT Setup Options are exchanged hop by hop.
PACE defines one Setup Option, which lets a PACE-aware relay or a
directly connected peer learn that the endpoint implements PACE:

| Setup Option | ID | Description |
|--------------|-----|-------------|
| pace-version | 0x50414301 | Highest PACE control-message version supported |

The `version` member of each control message remains authoritative.

### Idle Detection

In this binding, a dialog is idle ({{dialog-lifetime}}) while no
participant publishes an object on any of its tracks.

### Updating a Dialog

The controller changes the participant set or the expiration by
publishing UPDATE on its `ctrl` track with the complete context at the
next generation. Participants request changes with JOIN_REQUEST or
LEAVE; only the controller commits them. Parameter changes, such as
adding a modality, are proposed in `parameters` on UPDATE, and each
participant answers with ACCEPT or REJECT ({{lifecycle}}).

Participants MAY use MOQT's REQUEST_UPDATE message {{MoQ-TRANSPORT}}
to change per-subscription parameters, such as pausing delivery with
FORWARD=0, resuming with FORWARD=1, or changing priorities and
filters, without tearing down the subscription. REQUEST_UPDATE is the
right tool for track-level changes that do not need dialog-wide
agreement; pausing a video track while chat and ctrl keep flowing is
a typical case. Pausing a subscription does not stop the publisher
from producing objects and is not a cancellation.


### Recovery {#dialog-recovery}

PACE recovers from network and intermediary failures in several ways:

* QUIC Connection Migration: QUIC's connection ID lets a MOQT session
  survive network path changes (such as WiFi to cellular). The dialog
  state is unaffected.
* Relay Caching: Relays may cache recent objects, so a reconnecting
  agent can pick up what it missed without the peer retransmitting.
  Relays are not required to cache, and they never become the
  authoritative source of the dialog context.
* Dialog Resumption: After losing its MOQT session, which it detects
  through the QUIC idle timeout or a subscription timeout, an agent
  reconnects
  (to the same relay or an alternate one), re-issues PUBLISH_NAMESPACE
  and SUBSCRIBE_TRACKS on its agent prefix, resubscribes to the
  controller's `ctrl` track, and sends STATE_REQUEST with its last
  accepted generation. It applies the controller's STATE only after
  authenticating the controller and checking that the generation is not
  older than its last accepted one ({{generations}}). A join fetch from
  the last Location it received then shows which content was published
  while it was away, so it can decide whether to resend its own input.
* Join Fetch for Mid-Dialog Catch-Up: An agent joining a dialog in
  progress, or recovering after a disconnect, uses the fill fetch
  mechanism from {{MoQ-TRANSPORT}}. The subscriber issues SUBSCRIBE with
  FILL_PARAMETERS on the chat or operation track; the publisher opens a
  unidirectional fill fetch stream carrying the historical range
  (typically the latest complete group) before live objects resume on
  the subscription. "Catch up on prior content, then follow live"
  happens atomically, without a separate FETCH roundtrip. For the dialog
  context itself, STATE is authoritative; a fetched old `ctrl` object
  cannot establish the current lifecycle state by itself.
* Bounded Historical Fetch: To retrieve a specific range of past objects
  deterministically, for example replaying a task's output history,
  agents use FETCH with explicit Start and End Locations. The publisher
  confirms the actual End Location in FETCH_OK.
* Unreachable Controller: If the controller's `ctrl` track cannot be
  resubscribed, participants follow the unreachability rules in
  {{propagation}}: they suspend context-dependent actions and do not
  create a replacement dialog. A slow subscriber whose subscription ends
  with PUBLISH_DONE (TOO_FAR_BEHIND) resubscribes and resynchronizes
  with STATE_REQUEST.

### Cancellation {#cancel-over-moqt}

A participant publishes CANCEL on its `ctrl` track at critical
priority (0-15). For scope `operation`, `target` names a track the
sender publishes in the dialog and, optionally, a group on it:

~~~json
{
  "namespace": ["mcp", "tools", "search"],
  "track": "request",
  "group": 3
}
~~~

`namespace` lists the namespace fields that follow
`("pace","agents",{agent-id},{dialog-id})`. Without `group`, all work
started by objects on the track is cancelled. Each receiver doing the
affected work publishes CANCEL_ACK on its own `ctrl` track and stops
publishing objects for that work, ending a track that carried only
that work with PUBLISH_DONE.

Pausing delivery with REQUEST_UPDATE (FORWARD=0), unsubscribing, or
closing a MOQT session does not cancel work.

### Termination and Revocation

The controller ends the dialog by publishing TERMINATE on its `ctrl`
track. A participant leaves with LEAVE. Upon termination, pending
operations are cancelled, and dialog resources are released after a
configurable grace period.

After TERMINATE, each participant SHOULD send PUBLISH_DONE
{{MoQ-TRANSPORT}} on every dialog track it was publishing (ctrl, chat,
audio, video, and any operation tracks). PUBLISH_DONE signals that no
further objects will be delivered on the track, allowing subscribers
and relays to release state without waiting for timeouts. Neither
PUBLISH_DONE nor STOP_SENDING substitutes for TERMINATE.

When the controller publishes REVOKE, every participant stops
forwarding dialog context to the revoked participant and cancels any
subscriptions held only on its behalf ({{lifecycle}}). The deployment
also withdraws the revoked participant's authorization at the relay,
for example by letting its {{MoQ-C4M}} token expire or by refusing
revalidation, so that the relay stops delivering the participant's
subscriptions to the dialog's tracks.

When an agent is leaving the network entirely (not just a single
dialog), it cancels its PUBLISH_NAMESPACE for
`("pace","agents",{agent-id})`. Relays then send NAMESPACE_DONE to
agents with matching SUBSCRIBE_NAMESPACE subscriptions.

# Multi-Modal Data Exchange {#data-exchange}

Over the MOQT binding, a dialog can carry several data modalities
concurrently, each with appropriate quality of service. This content
is outside the dialog context; a change of modality does not change
the dialog ({{propagation}}).

## Modality Types

PACE defines the following data modality classes:

| Modality | Latency | Examples | Delivery |
|----------|---------|----------|----------|
| Real-time | < 100ms | Voice, video, screen share | Continuous stream |
| Semi-real-time | < 1s | Chat messages, streaming LLM output | Ordered objects |
| Non-real-time | Best effort | Tool calls, file transfers, documents | Reliable delivery |

These classes correspond to the low-latency loss-tolerant, reliable
ordered, and high-throughput reliable delivery semantics of
{{Section 8.1 of ARCH}}.

## Channel Architecture {#channels}

Each modality maps to dedicated MOQT tracks within the Dialog
Communication Namespace ({{namespace}}). Different modalities are
isolated by track name while sharing the dialog context and
authorization.

Within a track, a MOQT group is a synchronization point. The objects
in a group carry what belongs together at that point, such as one
message, one request and its incremental results, or one phase of an
operation, and relays carry them together. A publisher starts a new
group at each point where a receiver can begin consuming the track
without earlier objects, so a subscriber that joins or recovers starts
at a group boundary ({{dialog-recovery}}).

## Priority and Quality of Service

MOQT's 0-255 priority scale enables differentiated treatment of messages
based on urgency and modality. PACE defines the following tiers of
subscriber priority:

| Priority Range | Category | Use |
|----------------|----------|-----|
| 0-15 | Dialog Control | All control messages on the `ctrl` track, including CANCEL, ERROR, and REVOKE |
| 16-31 | Urgent Signals | Application signals that must preempt content, such as a request for a human |
| 32-63 | Real-time Media | Voice/video frames |
| 64-95 | Interactive | Chat messages, streaming LLM tokens |
| 96-127 | Standard Operations | Tool calls, request/response |
| 128-159 | Discovery | Capability cards, agent advertisements |
| 160-191 | Background | Telemetry, non-critical notifications |
| 192-255 | Bulk Transfer | File transfers, documents |

MOQT relays forward Publisher Priority unchanged, so PACE applies
policy through subscriber priority, which MOQT applies before publisher
priority. A subscriber sets the subscriber priority of each
subscription according to its policy for that peer and track, and can
change it with REQUEST_UPDATE, so a publisher cannot raise the urgency
of its traffic beyond what its subscribers allow. A subscriber MUST
subscribe to a `ctrl` track with a subscriber priority in the Dialog
Control tier.

## Request/Response Pattern {#request-response}

Request/response interactions use coordinated publish operations.
Agent A publishes a request object on its own track
`("pace","agents","agent-a",{dialog-id}) -- "ops/{req-id}"`. Agent B, which
has subscribed to A's dialog namespace, receives the request, processes
it, and publishes the response on its own corresponding track
`("pace","agents","agent-b",{dialog-id}) -- "ops/{req-id}"`. Agent A receives
the response through its subscription to B's dialog namespace.

For a detailed example of request/response over MOQT tracks, see
{{MCP-MOQT}} which defines this pattern for MCP tool invocations.

## Streaming Pattern {#streaming}

Long-running operations produce incremental results as MOQT objects.
The publisher starts a new group at each synchronization point
({{channels}}), such as a phase transition (initialization, progress,
completion), and the objects in a group carry the incremental data for
that phase.

Late-joining subscribers catch up mid-operation with a join fetch, and
retrieve a specific range with a bounded fetch ({{dialog-recovery}}).

Upon operation completion, the publisher sends PUBLISH_DONE on the
operation track to signal end-of-stream. Receivers treat PUBLISH_DONE
as the authoritative completion marker; publishers MUST NOT emit
further objects on that track after PUBLISH_DONE.

To cancel an in-progress streaming operation, the requester publishes
CANCEL on its `ctrl` track ({{cancel-over-moqt}}), or the application
protocol's own cancel message on its request or operation track. The
publisher then stops the operation and sends PUBLISH_DONE to end the
stream. REQUEST_UPDATE with
FORWARD=0 only pauses delivery to that subscriber; it does not cancel
the operation.

## Real-Time Media Exchange

Audio and video streams use dedicated tracks (`"audio"`, `"video"`)
with ascending group order and high priority (32-63),
ensuring media frames preempt lower-priority data under congestion.

# Communication Topologies {#topologies}

PACE supports multiple communication topologies through MOQT's relay
fan-out:

* Point-to-Point: Two agents publish and subscribe to each other's
  dialog tracks. Used for tool invocation, task delegation, and
  bilateral collaboration.
* Point-to-Multipoint (Fan-Out): One agent publishes; multiple agents
  subscribe. The relay handles fan-out without the publisher maintaining
  per-subscriber state. Used for broadcast notifications and shared
  context distribution.
* Multi-Party: All participants publish on their own tracks and
  subscribe to each other's tracks within the same dialog-id. The
  controller adds a participant with UPDATE; existing participants see
  the new participant in the context and subscribe to its dialog
  namespace.
* Hierarchical Teams: A coordinator creates child PACE dialogs to
  delegate subtasks. Each level operates as a separate dialog with
  narrowed authorization scope, and each child's `parent_dialog_ids`
  links it to the dialogs above it ({{dialog-context}}). Delegation
  chains ({{delegation}}) maintain an auditable path from the
  original user authorization, and CANCEL with scope `subtree` stops the
  work below a level ({{cancellation}}).

# Agent Identity and Discovery {#identity-discovery}

## Agent Identity Model

PACE treats the agent as an authenticated principal distinct from the
user it represents. Separating the two makes it possible to revoke an
agent without affecting the user, scope an agent to a subset of what
the user is allowed to do, and audit what the agent did on its own
versus what the user initiated.

PACE does not define a new identity token format or claim set. The
credential an agent presents in the `credentials` member of the
control message it uses to open, accept, or join a dialog
({{control-encoding}}) identifies:

* the agent, by an identifier that matches its participant identifier
  in the dialog;
* the user, workload, or organization the agent acts for; and
* when the agent acts for another agent, the delegation chain
  ({{delegation}}).

In JWT-based formats, these map to the registered claims `sub`, `iss`,
`iat`, and `exp` {{RFC7519}} and to the `act` (actor) claim
{{RFC8693}} for delegation. Other formats carry the equivalent
information in their own fields. The token format and the trust
framework are chosen by the deployment.

### Credential Mechanisms {#identity-formats}

Agents present credentials using existing mechanisms. The mechanism in
use is advertised in the Agent Card ({{agent-card}}) and indicated in
the `credentials` member of control messages; it is not negotiated in
MOQT SETUP, which is hop by hop ({{moqt-setup-extensions}}).

| Mechanism | Identity | Authorization | Reference |
|-----------|----------|---------------|-----------|
| JWT | Agent and principal claims | Scope claims | {{RFC7519}} |
| SD-JWT | Selectively disclosed claims | Selectively disclosed scope claims | {{RFC9901}} |
| SD-Card | Attested agent metadata, key-bound presentation | Disclosure per discovery context | {{SD-CARD}} |
| OAuth 2.0 access token (JWT or opaque) | Token claims | Delegated user authorization | {{RFC6749}} |
| GNAP | | Fine-grained, continuous grants | {{RFC9635}} |
| WIMSE workload credentials | Workload identity | With deployment policy | {{WIMSE-CREDS}} |
| mTLS client certificate | Infrastructure-anchored identity | With deployment policy | {{RFC8446}} |
| Common Access Token (CAT) | | Relay-level namespace authorization | {{MoQ-C4M}} |

A deployment profile MUST pick at least one mechanism for identity and
one for authorization; one mechanism can provide both. Receivers MUST
verify a credential's signature, issuer, and expiration before acting
on its claims, and validate authorization using the rules of the
mechanism in use.

### Delegation Chains {#delegation}

When an agent acts on behalf of another agent, its credential carries
the delegation chain, such as nested `act` claims {{RFC8693}}, tracing
the authorization path (for
example, User → Coordinator → Researcher → Tool). Each entry names
the granter, the agent being granted, and the scope granted at that
hop. The receiver walks the chain and MUST reject it if any hop
broadens scope relative to its granter (see {{authorization}}).

An agent that holds an SD-Card can obtain such a token with OAuth 2.0
Token Exchange, presenting its SD-Card as the actor token; the issued
token's `act` claim then carries the `sub` and `iss` of the SD-Card
({{Section 7.1 of SD-CARD}}).

### Selective Disclosure {#selective-disclosure}

Agents cross trust boundaries where different peers need different
subsets of claims. A tool-side peer may need only the agent identifier
and its authorization; it does not need the full delegation chain or
the principal.
Agents SHOULD support selective disclosure so they reveal only what
each peer requires.

For agent metadata, PACE uses SD-Card {{SD-CARD}}: an Agent Registry
attests the agent's metadata once, and the agent discloses to each
peer only the claims that peer is authorized to see, while the peer
can check that each disclosed claim is issuer-attested and unmodified.
Agent Cards ({{agent-card}}) are presented this way. Identity
assertions and authorization proofs in `credentials` use the selective
disclosure features of the mechanism in use ({{identity-formats}}).

Selective disclosure keeps metadata confidential; it does not make
agents anonymous. The `sub` claim of an SD-Card is always disclosed
and is stable across issuances, so presentations of the same SD-Card
can be linked ({{Section 3.1 of SD-CARD}}). Linkage through agent and
dialog identifiers is mitigated by the measures in {{privacy}}, not
by selective disclosure.

### Key-Bound Presentation {#key-binding}

A presentation proves that the presenter holds the credential only
when it is bound to the verifier and to a fresh value the verifier
supplied, such as the Key Binding JWT of an SD-Card
({{Section 6 of SD-CARD}}). In PACE, a participant that will verify a
peer's credentials includes a `nonce` member in its control message
({{control-encoding}}). The peer's next control message to that
participant carries in `credentials` a presentation whose nonce equals
that value and whose audience is the verifier's agent-id.

When a dialog opens ({{opening}}), the controller sends a nonce in
OPEN, and the invitee's ACCEPT carries a presentation bound to it,
together with the invitee's own nonce. The controller then presents
its credentials, bound to the invitee's nonce, in the UPDATE that
marks the invitee `active`. A joiner and the controller do the same
with JOIN_REQUEST, UPDATE, and ACCEPT ({{dialog-discovery}}). A
participant that requires a key-bound presentation and does not
receive one, or receives one that fails verification, MUST NOT treat
the peer as authenticated.

## Agent Discovery {#agent-discovery}

Agent discovery uses MOQT's namespace operations to find agents and
follow their activity. Discovery operates on the Agent Namespace scope
defined in {{namespace}}. Each agent is identified by a globally unique
agent-id (UUID), verifiable via the Agent Card (see {{agent-card}}).

### Phase 1: Discovering Agents on the Network

1. Each agent announces its presence by issuing PUBLISH_NAMESPACE on
   `("pace","agents",{agent-id})`.
2. Agents discover peers by issuing SUBSCRIBE_NAMESPACE on the common
   prefix `("pace","agents")`.
3. The relay sends NAMESPACE messages to subscribers for each matching
   PUBLISH_NAMESPACE, enabling agents to learn about each other without
   prior knowledge.

If an agent-id is known out-of-band (e.g., from a registry or URL),
agents MAY skip Phase 1 and proceed directly to Phase 2.

### Phase 2: Following an Agent

Once Agent B knows Agent A's namespace prefix, B issues SUBSCRIBE_TRACKS
on `("pace","agents","agent-a")`. From then on the relay forwards every
PUBLISH from A that matches the prefix, which covers A's Agent Card and
any future dialog tracks A publishes.

1. B issues SUBSCRIBE_TRACKS on `("pace","agents","agent-a")`.
2. The relay forwards A's PUBLISH for the `"card"` track to B.
3. B accepts the PUBLISH, which implicitly subscribes it to the card
   track, and reads A's Agent Card objects.
4. When A later publishes dialog tracks under
   `("pace","agents","agent-a",{dialog-id})`, the relay forwards them
   to B by prefix match. B discovers and joins dialogs without any
   separate notification mechanism.

A does the same for B with SUBSCRIBE_TRACKS on
`("pace","agents","agent-b")`.

### Agent Card {#agent-card}

Each agent publishes an Agent Card on track `"card"` under its namespace
`("pace","agents",{agent-id})`. When capabilities change, the agent
publishes a new object (incrementing the MOQT group).

All Agent Cards MUST include:

* Agent identifier (UUID) and display name
* Supported modalities and protocols
* Authentication schemes
* Identity claims (issuer, public key, expiration)

PACE does not define its own card format. An Agent Card SHOULD be the
SD-Card {{SD-CARD}} of the agent's application protocol, such as an
A2A SD-Card ({{a2a-binding}}), whose `vct` claim identifies the
protocol binding. The SD-Card's core claims carry the identity claims
and display name, and its binding claims carry the modalities,
protocols, and authentication schemes. The card discloses the agent's
PACE entry point in the protocol's own metadata (for A2A, an element
of `supportedInterfaces`), and that entry names the agent's namespace
`("pace","agents",{agent-id})`. Receivers MUST check that this
namespace equals the one on which the card was published.

The `"card"` track is delivered through relays to every subscriber,
so its objects cannot be bound to one verifier. An Agent Card on the
track is a presentation for the `public` discovery context without a
Key Binding JWT ({{Section 5.3 of SD-CARD}}). Receivers MUST verify
it as {{Section 6.3 of SD-CARD}} requires, apart from key binding,
before acting on its claims. Such a card proves that its claims are
attested and unmodified, but not that the publisher is the agent. A
participant that relies on the agent's identity MUST obtain a
key-bound presentation in `credentials` when the dialog opens or the
agent joins ({{key-binding}}); that presentation MAY disclose claims
of a richer discovery context the participant is authorized for.

An SD-Card's `sub` is stable across issuances. An agent that uses
pairwise or per-dialog agent-ids ({{privacy}}) uses a separate
SD-Card, with a separate `cnf` key, for each agent-id it presents
({{Section 4 of SD-CARD}}); otherwise the `sub` links its agent-ids.

# Protocol Bindings {#protocol-bindings}

PACE manages dialog identifiers, lifecycle, and context propagation.
Application-layer agent protocols keep their native message formats
and semantics, and carry the dialog context through their own
extension points ({{carrying-dialog-context}}). PACE does not change
those protocols; any standardized mapping is coordinated with their
maintainers.

Over the MOQT binding, an application protocol's messages also need a
place on MOQT tracks. This section defines that placement for MCP,
the Personal Agent Protocol (Poppy), A2A, and a generic
JSON-RPC baseline for custom protocols. Each binding runs inside a
PACE dialog, using the Dialog Communication Namespace ({{namespace}})
and the channel architecture ({{data-exchange}}). Multiple bindings
can coexist in a single dialog, each under its own protocol namespace
field, so one agent can speak A2A to a peer and MCP to a tool in the
same dialog.

## Carrying Dialog Context in Application Protocols {#carrying-dialog-context}

An application message joins a dialog by carrying a dialog reference
in the protocol's own extension point, whether or not the protocol
runs over MOQT. The reference is this object, under the metadata key
`org.ietf.agentproto/dialog-context`:

~~~json
{
  "dialog_id": "550e8400-e29b-41d4-a716-446655440000",
  "generation": 3
}
~~~

`generation` is the latest generation the sender knows. The
controller's `ctrl` track stays authoritative; a receiver that needs
the full context sends STATE_REQUEST.

| Protocol | Carried in | Keep distinct from |
|---|---|---|
| MCP | `_meta` | MCP session and JSON-RPC request IDs |
| Poppy | Track namespace ({{poppy-binding}}) | Conversation ID |
| AutoGen | Message `metadata` | Conversation ID |
| A2A | Message `metadata` | `contextId`, `taskId` |

A dialog-id MUST NOT be used as a task, request, content, or session
identifier, or as a credential.

## Binding Architecture

A binding specifies:

* Protocol identifier: the namespace field that follows the
  dialog-id.
* Namespace pattern: how operations map to namespace fields and track
  names within the agent's dialog namespace.
* Message serialization: how native messages are encoded in MOQT
  object payloads. Bindings SHOULD use the native wire format as the
  object payload ({{message-serialization}}).
* Dialog reference: where messages carry the dialog reference
  ({{carrying-dialog-context}}).
* Priority: which PACE priority tier its tracks use ({{data-exchange}}).

A complete mapping of each protocol operation to MOQT primitives
belongs in a protocol-specific document, such as {{MCP-MOQT}} for MCP.
* Identity and authorization: how the protocol's own identity and
  authorization constructs (if any) relate to the credential
  mechanisms ({{identity-formats}}) in this document.

Protocols use distinct protocol namespace fields within PACE dialogs.
In the tables of this section, a pattern such as
`("a2a", "task") -- {task-id}` gives the namespace fields that follow
`("pace", "agents", {agent-id}, {dialog-id})`, then the track name.

In the examples, D is the dialog-id.

| Protocol | Protocol Fields | Example Full Track Name |
|----------|--------------|-------------------|
| MCP | `"mcp"` | `("pace","agents","fs-server",D,"mcp","tools","read") -- "response"` |
| Poppy | `"poppy"` | `("pace","agents","acme",D,"poppy","conversation") -- "events"` |
| A2A | `"a2a"` | `("pace","agents","agent-a",D,"a2a","task") -- "t1"` |
| Generic | `"ext", {proto}` | `("pace","agents","agent-a",D,"ext","myproto","rpc") -- "call"` |

## MCP Binding {#mcp-binding}

The Model Context Protocol {{MCP}} binding enables tool and resource
access for agents. Within a PACE dialog, MCP tracks add an `"mcp"`
namespace field after the dialog-id, under the namespace of the agent
that publishes the track:

~~~
Namespace: ("pace", "agents", {agent-id}, {dialog-id}, "mcp",
            {category}, ...)
Tracks:    {track-name}
~~~

The complete MCP over MOQT specification, covering track structure,
operation mapping, message serialization, Agent Skills, and relay
support, is defined in {{MCP-MOQT}}. PACE adopts its track semantics.
The mapping is mechanical: the leading `(mcp, {session-id})` fields of
an MCP over MOQT namespace are replaced by `("pace", "agents",
{agent-id}, {dialog-id}, "mcp")`, and the remaining namespace fields
and the track name are kept unchanged. For example:

~~~
MCP over MOQT:
  (mcp, {session-id}, tools, {tool-name}) -- request
  (mcp, {session-id}, tools, {tool-name}) -- response
  (mcp, {session-id}, resources) -- {resource-uri}
Within PACE:
  ("pace","agents",{client-id},{dialog-id},"mcp","tools",{tool-name})
      -- "request"
  ("pace","agents",{server-id},{dialog-id},"mcp","tools",{tool-name})
      -- "response"
  ("pace","agents",{server-id},{dialog-id},"mcp","resources")
      -- {resource-uri}
~~~


The standalone MCP session discovery flow of {{MCP-MOQT}} is not used
within PACE: PACE supplies the dialog-id, and peers learn each
other's MCP tracks through SUBSCRIBE_TRACKS on the agent prefix.

MCP messages keep their native JSON-RPC format as the object payload
({{message-serialization}}) and carry the dialog reference in `_meta`
({{carrying-dialog-context}}). Key operations map as follows:

| MCP Operation | MOQT |
|---------------|------|
| `tools/call` | Request object in a new group on the client's `("mcp","tools",{tool-name}) -- "request"` track; the result in the same group on the server's matching `"response"` track |
| Progress and partial results | Further objects in that group on the `"response"` track ({{streaming}}) |
| `resources/read` | FETCH or SUBSCRIBE on the server's `("mcp","resources") -- {resource-uri}` track |
| `notifications/cancelled` | Applied from PACE CANCEL ({{cancellation}}) |

MCP tracks use the Standard Operations priority tier
({{data-exchange}}).

An MCP server that holds an MCP SD-Card returns a key-bound
presentation to the client that requests one
({{Section 8.2.4 of SD-CARD}}). That presentation is specific to the
requesting client, and MCP requires the response carrying it not to
be shared with other clients. Within PACE, the response track is
scoped to the dialog, and relays MUST NOT serve objects of a dialog's
tracks to subscribers outside that dialog. The nonce and audience
prevent replay of the presentation, but other participants of the
dialog can read the claims it discloses, so the server discloses only
claims that every participant may see.

When a Key Binding JWT carries an `interaction_id`, an agent includes
it in the MCP requests it makes for that interaction
({{Section 8.5 of SD-CARD}}). Agents MAY use the dialog-id as the
`interaction_id`, so that presentations and messages correlate on the
same identifier.

## Personal Agent Protocol Binding {#poppy-binding}

The Personal Agent Protocol (Poppy) {{POPPY}} lets a person's own
agent (the Personal Agent) sign in to a Company and talk to the
Company's agent (the Company Agent). Poppy defines discovery through a
`poppy.json` document, OAuth-based identity with pairwise user
identifiers, API access through OpenAPI and MCP, and a Conversations
protocol over HTTPS.

This binding carries Poppy Conversations over PACE. Poppy discovery,
OAuth sign-in, web browsing, feedback and excluded-task documents are
unchanged and continue to use HTTPS. Poppy APIs of type `mcp` can use
the MCP binding ({{mcp-binding}}) when the Company offers MCP over
MOQT.

### Roles and Discovery

The Personal Agent is the PACE dialog initiator and the Company Agent
is the responder. A Company that offers this binding lists it in the
`agent.protocols` array of its `poppy.json`. Poppy ignores protocol
types it does not recognize, so the entry can sit alongside the
default `poppy` HTTPS entry:

~~~json
{
  "agent": {
    "protocols": [
      { "type": "poppy", "endpoint": "https://acme.example/agent" },
      {
        "type": "pace",
        "binding": "poppy",
        "relayEndpoint": "moqt://relay.acme.example:4443",
        "namespace": ["pace", "agents", "acme"]
      }
    ]
  }
}
~~~

The `pace` protocol type is not defined by Poppy Draft 0.3. Until Poppy
defines it, the entry is carried as a Poppy extension named under a
domain the publisher controls, as Poppy's extension rules require.
The Personal Agent MUST apply Poppy's `poppy.json` validation (domain
match and issuer checks) before using the entry.

A Company that holds a Company SD-Card ({{Section 8.3 of SD-CARD}})
carries the `agent` member of its `poppy.json` in the SD-Card's
selectively disclosable `agent` claim. It can therefore leave the
`pace` entry out of its public `poppy.json` and disclose it only to
the Personal Agents it chooses. A disclosed `pace` entry that also
appears in `poppy.json` MUST match it, as SD-Card's consistency rules
require.

### Namespace Structure

~~~
Namespace: ("pace", "agents", {agent-id}, {dialog-id}, "poppy",
            "conversation")
Tracks:    "messages" | "requests" | "events" | "deltas"
~~~

| Publisher | Track | Content |
|-----------|-------|---------|
| Personal Agent | `messages` | Poppy messages sent by the Personal Agent |
| Personal Agent | `requests` | Conversation requests: handoff to a human |
| Company Agent | `events` | Poppy events: `message`, `state`, `authorization`, `user_requested`, `direct_opened`, `direct_closed` |
| Company Agent | `deltas` | Non-durable `text-delta` events |

The Company Agent's `{agent-id}` is the namespace advertised in
`poppy.json`. The Personal Agent's `{agent-id}` MUST be pairwise: it
MUST differ for each Company, MUST NOT be derived from the person's
identity, and SHOULD NOT equal the Poppy User ID. A Personal Agent MAY
use a fresh `{agent-id}` for each dialog. This preserves Poppy's
property that a Company knows a person only by an opaque identifier
that differs at every Company. It also stops relays, which always see
namespaces, from linking a person's conversations across Companies.
Personal Agents do not publish an Agent Card or answer agent discovery
({{agent-discovery}}). The Company is the discoverable party, so the
Personal Agent opens dialogs through the Company Agent's `joins`
namespace ({{opening}}).

### Operation Mapping

Poppy messages and events keep their native JSON format as the object
payload ({{message-serialization}}). The dialog reference is not
carried in them, because the dialog-id is in every track namespace.

| Poppy Conversations | PACE / MOQT |
|---------------------|-------------|
| Start a conversation | OPEN through the Company Agent's `joins` namespace ({{opening}}), with the Personal Agent as controller. The Poppy conversation ID is assigned as in Poppy and is distinct from the dialog-id |
| Send a message | One object per message, in a new group, on the `messages` track |
| Read events, resume from a cursor | SUBSCRIBE to the `events` track, with FILL_PARAMETERS or FETCH from the Location after the last event received |
| Request a human | A `handoff` object on the `requests` track |
| Direct Conversation | A new dialog whose `parent_dialog_ids` starts with the parent dialog-id |
| Close | TERMINATE |

Each event is one object in its own group, so an event's MOQT Location
serves as the Poppy cursor. The `messages`, `requests`, and `events`
tracks are durable and MUST NOT use a finite delivery timeout; the
`deltas` track SHOULD use OBJECT_DELIVERY_TIMEOUT. The Company Agent
MUST treat a repeated message `id` from the same User as a duplicate,
as Poppy requires. Handoff requests use the Urgent Signals priority
tier, and messages and events the Interactive tier ({{data-exchange}}).

### Identity and Authorization

This binding reuses Poppy identity and authorization unchanged.
Sign-in, token refresh, and client metadata stay on HTTPS.

* Credentials: The Personal Agent is identified by its Poppy
  `client_id`, and the person only by the pairwise Poppy User ID. It
  sends its Poppy Session JWT, and its access token when signed in, in
  the `credentials` member of OPEN, and new ones on its next control
  message after a refresh or sign-in ({{control-encoding}}).
* Ownership: The conversation belongs to the `client_id` and User ID
  that opened it. The Company MUST reject control messages from any
  other client, User, or account, and MUST authorize subscriptions to
  the conversation's `events` and `deltas` tracks only for that owner.
  Because the relay forwards these tracks to every agent following
  the Company Agent's prefix, the relay enforces this
  ({{relay-authorization}}): only the owner's token covers
  `("pace","agents",{company-id},{dialog-id})`.
* Signing in: When the Company Agent needs account access, it publishes
  an `authorization` event; the Personal Agent signs in over HTTPS and
  continues the same dialog with new credentials. Because control
  messages pass through relays, the Personal Agent SHOULD use DPoP-bound
  tokens {{RFC9449}} where the Company supports them.

* Personal Agent SD-Card: A Personal Agent presents its SD-Card with
  the Poppy SD-Card extension over HTTPS, unchanged
  ({{Section 8.3.5 of SD-CARD}}). The SD-Card's `sub` and `cnf` key
  identify the Personal Agent, and so the person, to every Company
  that verifies it ({{Section 8.3.7 of SD-CARD}}). Pairwise
  `{agent-id}` values do not hide that link, so a Personal Agent
  SHOULD present its SD-Card only to Companies with which the person
  has, or is setting up, a relationship. Where the Company only needs
  to know that the Personal Agent is attested, it SHOULD accept a
  Privacy Pass token {{RFC9576}} instead.

Editor's note: A Poppy Session JWT is bound to an HTTP method and URL
(`htm`, `htu`). How these claims apply to a PACE control message is to
be agreed with the Poppy authors. The same question applies to the
Poppy SD-Card extension, whose Key Binding JWT nonce is the `jti` of
the Session JWT. A Personal Agent's `credentials` in this binding are
a Session JWT, not an SD-Card presentation, so whether the Company
sends a `nonce` ({{key-binding}}) and how the Personal Agent answers
it is also to be agreed.

## A2A Binding {#a2a-binding}

The Agent-to-Agent Protocol {{A2A}} binding places A2A messages on
tracks under each agent's dialog namespace, using the `"a2a"` protocol
namespace field:

| Track Pattern | Content |
|---------------|---------|
| `("a2a", "request") -- {request-id}` | A2A JSON-RPC requests |
| `("a2a", "response") -- {request-id}` | A2A JSON-RPC responses |
| `("a2a", "task") -- {task-id}` | Task status and artifact updates |

A2A messages keep their native JSON-RPC 2.0 format as the object
payload ({{message-serialization}}) and carry the dialog reference in
the message `metadata` ({{carrying-dialog-context}}). Key operations
map as follows:

| A2A Operation | MOQT |
|---------------|------|
| `SendMessage` | Request object on the client's `request` track; the response on the server's `response` track with the same request-id |
| `SendStreamingMessage` | Response objects on the `response` track, ended by PUBLISH_DONE ({{streaming}}) |
| `GetTask` | FETCH on the server's `("a2a","task") -- {task-id}` track |
| `SubscribeToTask` | SUBSCRIBE on that task track, with FILL_PARAMETERS to catch up |
| `CancelTask` | Applied from PACE CANCEL ({{cancellation}}) |

A response that creates a task carries the A2A task-id, which names
the server's task track. A2A tracks use the Interactive priority tier
for requests and responses and the Standard Operations tier for task
updates ({{data-exchange}}). An A2A agent advertises PACE support
through A2A's own Agent Card extension mechanism, pointing to its PACE
Agent Card ({{agent-card}}).

An A2A agent that holds an A2A SD-Card ({{Section 8.4 of SD-CARD}})
publishes it as its PACE Agent Card. Its `supportedInterfaces` claim
is disclosed per element and its `capabilities` claim selectively,
so the agent can disclose its PACE interface and extension only in
the discovery contexts it chooses. The SD-Card A2A extension, which
carries a key-bound presentation in the metadata of the first Message
or Task in a context, works unchanged over these tracks because A2A
messages keep their native format. An A2A `contextId` is used within
one dialog, so the agent presents its SD-Card at most once per
`contextId` in that dialog.

A complete mapping of A2A operations to MOQT is left to a separate
document coordinated with the A2A maintainers, as {{MCP-MOQT}} does
for MCP.

## Generic Binding {#jsonrpc-binding}

A protocol without its own binding uses the `"ext"` protocol namespace
field followed by a field naming the protocol:

~~~
Namespace: ("pace", "agents", {agent-id}, {dialog-id}, "ext",
            {protocol-name}, ...)
Tracks:    {identifier}
~~~

The protocol's native messages are the object payloads
({{message-serialization}}), and they carry the dialog reference in
the protocol's own extension point ({{carrying-dialog-context}}). The
protocol defines its own namespace fields and track names below
`{protocol-name}`.

# Authorization and Security {#authorization}

## Authorization Model

Access in PACE is granted through authorization proofs scoped to the
operations an agent may perform. PACE does not define a new
authorization protocol or scope syntax. The scope representation,
token format, issuance mechanism, and verification policy come from
the mechanism the deployment selects ({{identity-formats}}).

### Delegated Authorization {#delegated-authz}

Each delegation hop MUST narrow or preserve the scope. If Agent A
holds scope S, it can request a sub-scope S' ⊂ S for Agent B, and B
can narrow again to S'' ⊂ S' for a downstream tool. No agent down
the chain may hold more than its delegator granted.

Authorization proofs travel in the `credentials` member of OPEN,
ACCEPT, and JOIN_REQUEST. The receiver validates the proof together
with the full delegation chain ({{delegation}}). Proofs are refreshed
before they expire by sending new credentials on a later control
message; long-lived dialogs SHOULD renew the proof in place rather
than terminating the dialog. Revoking an agent's authorization ends
its propagation relationship through REVOKE ({{lifecycle}}).

### Confirmation and Evidence

Some operations are high-risk enough that an authorization token alone
is not sufficient. For those, PACE lets a peer require cryptographic
evidence of approval, such as a human confirmation, a policy-check
result, or an MFA attestation, before proceeding. The evidence format
is not fixed; it can be a signed assertion, a SCITT receipt, or an
out-of-band attestation.

## Transport Security

All PACE traffic is encrypted under TLS 1.3 because QUIC requires it.
MOQT relays terminate QUIC and TLS on each hop, so transport-layer
authentication identifies only the adjacent hop. PACE therefore
authenticates participants at the application layer, through the
`credentials` member of control messages, as {{Section 7.2 of ARCH}}
requires when intermediaries terminate TLS.
Identity assertions and authorization proofs are signed and
short-lived. MOQT Common Access Tokens {{MoQ-C4M}} handle
namespace-level authorization at the relay. Relays cannot read payload
content unless the deployment explicitly trusts them to.

### Relay Authorization {#relay-authorization}

Following an agent ({{agent-discovery}}) subscribes to its whole
prefix, so without further checks the relay would forward every
dialog track the agent publishes to every follower, including
dialogs the follower is not part of. The relay therefore checks each
track it forwards for a SUBSCRIBE_TRACKS against the subscriber's
token, not only the subscribed prefix, and forwards only tracks the
token covers.

The `moqt` claim of a Common Access Token matches each Track
Namespace field exactly or by prefix {{MoQ-C4M}}, so a token can be
scoped to a dialog without a new claim:

~~~
Follow agent A (card only):
  [[SUBSCRIBE_NAMESPACE, SUBSCRIBE],
   ["pace","agents","agent-a",nil], "card"]
Participate in dialog D of agent A:
  [[SUBSCRIBE, FETCH],
   ["pace","agents","agent-a",D]]
~~~

A controller, or the authorization server it relies on, issues a
token scoped to a dialog when it admits a participant, and stops
revalidating it ({{Section 2.2 of MoQ-C4M}}) when the participant
leaves or is removed.

Editor's note: {{MoQ-C4M}} defines no action for SUBSCRIBE_TRACKS
and does not yet say that a relay checks each forwarded track against
the token. Both are to be raised with its authors.

## Privacy Considerations {#privacy}

PACE dialog and participant identifiers (dialog-ids and agent-ids)
can persist across
intermediaries and trust boundaries. If several parties see them in
the clear, they can be used to correlate interactions that would
otherwise look unrelated. This is a known risk for any dialog
management protocol. Deployments mitigate it as follows:

* Identity claims and agent metadata are disclosed selectively
  ({{selective-disclosure}}): agents reveal only what each peer
  needs. Selective disclosure does not hide the agent's identity:
  an SD-Card's `sub` and `cnf` key link every presentation of it,
  so an agent that uses pairwise agent-ids uses a separate SD-Card
  for each ({{agent-card}}).
* Authorization proofs are narrowed to the minimum scope and
  refreshed before expiration so intermediaries cannot replay broad
  grants.
* Agents acting for an individual person SHOULD use pairwise or
  per-dialog agent-ids in their dialog namespaces, so that relays
  cannot link that person's dialogs with different peers. The Poppy
  binding requires this ({{poppy-binding}}).
* Dialog-ids SHOULD be fresh per dialog. Reusing a dialog-id across
  unrelated interactions re-introduces the linkage risk the identifier
  is supposed to avoid.
* Payload content SHOULD remain encrypted end-to-end with respect to
  relays unless the relay is explicitly trusted.
* Long-lived dialogs SHOULD rotate keys periodically; QUIC provides
  the key material lifecycle.
* Agent Cards SHOULD advertise only what discovery requires. Relays
  and every subscriber to the `"card"` track see it. Finer capability
  details can be disclosed in a key-bound presentation after a dialog
  begins ({{agent-card}}).

Relay operators MUST NOT retain content past operational need. Agents
SHOULD send only what the task requires.

# Scalability and Reliability {#scalability}

PACE inherits MOQT's relay architecture for geographic distribution
and load management:

* Multiple subscribers to the same track result in a single upstream
  subscription, which reduces origin load.
* Edge relays cache content close to subscribers, which cuts
  round-trip latency.
* Relay failures stay localized; other paths keep operating.

## Failure Modes and Recovery

Agent network loss and relay failure are recovered as described in
{{dialog-recovery}}. An unreachable participant or controller is
handled by the rules in {{propagation}}, and a dialog that outlasts its
expiration or idle timeout ends as described in {{dialog-lifetime}}.

# Security Considerations

The threats described in {{Section 10 of ARCH}} apply to PACE.

QUIC and TLS 1.3 0-RTT data can be replayed. Participants MUST NOT
send control messages that change state or cancel work (OPEN, ACCEPT,
UPDATE, JOIN_REQUEST, LEAVE, REVOKE, TERMINATE, CANCEL) in 0-RTT data.

TODO: further considerations.

# IANA Considerations

TODO

--- back

# Example Workflows {#example-workflows}

The examples below share these conventions:

* `D1` to `D5` stand for dialog-ids (UUIDs). `A`, `B`, and `C` are
  agents with agent-ids `agent-a`, `agent-b`, and `agent-c`.
* Before each example, every agent has completed agent discovery
  ({{agent-discovery}}) and holds SUBSCRIBE_TRACKS on each peer's
  agent prefix. The relay therefore forwards every new track to the
  peers, and the steps do not repeat the relay hops.
* Each example lists the tracks by publisher, then the steps. `gen`
  is the dialog generation after a controller operation.

## Delegating a Task with A2A

A asks B to do a task. This example shows the complete dialog
lifecycle; the later examples abbreviate it.

~~~
A publishes:
  ("pace","agents","agent-a",D1) -- "ctrl"         OPEN, UPDATE,
                                                   TERMINATE
  ("pace","agents","agent-a",D1,"a2a","request") -- "r1"
                                                   task request
B publishes:
  ("pace","agents","agent-b",D1) -- "ctrl"         ACCEPT
  ("pace","agents","agent-b",D1,"a2a","response") -- "r1"
                                                   task result
~~~

1. A publishes OPEN on its `ctrl` track (gen 0, B `invited`).
2. B publishes ACCEPT on its own `ctrl` track.
3. A publishes UPDATE (gen 1, B `active`). The dialog is active.
4. A publishes the A2A request on its `request` track `r1`:
   `{"jsonrpc":"2.0","method":"message/send","params":{...},"id":"r1"}`,
   with the dialog reference in the message `metadata`
   ({{carrying-dialog-context}}).
5. B publishes the result on its `response` track `r1`.
6. A publishes TERMINATE (gen 2). B could instead have sent LEAVE.

## Calling an MCP Tool

A reads a file through an MCP server, `fs-tool`.

~~~
A publishes:
  ("pace","agents","agent-a",D2) -- "ctrl"
  ("pace","agents","agent-a",D2,"mcp","tools","readFile")
      -- "request"                                 tools/call
fs-tool publishes:
  ("pace","agents","fs-tool",D2) -- "ctrl"
  ("pace","agents","fs-tool",D2,"mcp","tools","readFile")
      -- "response"                                result
~~~

1. A opens the dialog with fs-tool (OPEN, ACCEPT, UPDATE).
2. A publishes the call as Object 0 of a new group, say Group 7, on
   its `readFile` request track:
   `{"jsonrpc":"2.0","method":"tools/call","params":{"name":"readFile",
   "arguments":{"path":"/data/report.csv"}},"id":"t1"}`.
3. fs-tool publishes the result in Group 7 of its `readFile` response
   track. The matching Group ID pairs the response with the request.
4. A makes further calls as new groups, or terminates the dialog.

## Streaming a Long-Running Tool Call

A asks `code-tool` to generate code, and the tool streams its output.
The tracks follow the previous example, with tool `generateCode` in
dialog `D3`.

1. A publishes the call as Group 5 on its `generateCode` request
   track.
2. code-tool publishes its output as objects in Group 5 of its
   response track (see the table below). A receives each object as
   soon as it is published.
3. To cancel, A publishes `notifications/cancelled` on its MCP control
   track,
   `("pace","agents","agent-a",D3,"mcp","control") -- "client-to-server"`
   {{MCP-MOQT}}. code-tool stops and publishes no further objects in
   Group 5.

| Object | Content |
|---|---|
| 0 | Progress: `{"status":"started","language":"python"}` |
| 1 | First code block |
| 2 | Second code block |
| 3 | Result: `{"status":"complete","totalLines":142}` |

## Interrupting a Voice Agent

A user's client, `U` (agent-id `user-u`), talks to a voice agent, `V`
(agent-id `agent-v`). V answers by voice while a tool call it made to
`search-tool` is still running. The user cuts in, and V has to stop
speaking and cancel the tool call at once.

~~~
U publishes:
  ("pace","agents","user-u",D5) -- "ctrl"          ACCEPT
  ("pace","agents","user-u",D5) -- "audio"         microphone
V publishes:
  ("pace","agents","agent-v",D5) -- "ctrl"         OPEN, UPDATE,
                                                   CANCEL
  ("pace","agents","agent-v",D5) -- "audio"        speech
  ("pace","agents","agent-v",D5) -- "chat"         reply text
  ("pace","agents","agent-v",D5,"mcp","tools","search")
      -- "request"                                 tools/call
search-tool publishes:
  ("pace","agents","search-tool",D5) -- "ctrl"     ACCEPT,
                                                   CANCEL_ACK
  ("pace","agents","search-tool",D5,"mcp","tools","search")
      -- "response"                                results
~~~

1. V opens the dialog with U (OPEN, ACCEPT, UPDATE) and adds
   search-tool the same way.
2. V answers the user. It publishes speech on its `audio` track as
   datagrams at media priority (32-63), with a short
   OBJECT_DELIVERY_TIMEOUT, and the reply text on `chat` at interactive
   priority (64-95). Its call to search-tool, Group 3 of the `search`
   request track, is still running.
3. The user starts speaking. U publishes microphone audio on its
   `audio` track, and the relay forwards each frame to V as it
   arrives. The dialog does not change.
4. V detects the user's speech and stops producing speech and text. It
   publishes CANCEL on its `ctrl` track at critical priority (0-15),
   with scope `operation` and a `target` naming Group 3 of its
   `search` request track ({{cancel-over-moqt}}). The cancellation is
   sent ahead of any `chat` objects V has already queued, and a loss on
   the audio datagrams does not delay it.
5. Speech objects that the relay has not delivered within their
   delivery timeout are dropped at the relay, so the user does not
   hear the rest of the old answer after cutting in.
6. search-tool applies the CANCEL as MCP `notifications/cancelled`,
   stops, publishes no further objects in Group 3, and publishes
   CANCEL_ACK with outcome `stopped` on its `ctrl` track. V
   listens to the rest of the user's audio and answers in new groups
   on its `audio` and `chat` tracks.

The dialog, its generation, and the MOQT sessions stay the same
throughout: an interruption changes the content of a dialog, not the
dialog. If the dialog's flows shared one ordered connection, the
cancellation in step 4 would wait behind the output V had already
sent.

## Collaborating in a Multi-Party Dialog

A coordinates research by B, a web researcher, and C, a data analyst.

~~~
A publishes:
  ("pace","agents","agent-a",D4) -- "ctrl"         OPEN, UPDATE,
                                                   TERMINATE
  ("pace","agents","agent-a",D4) -- "chat"         assignments
B publishes:
  ("pace","agents","agent-b",D4) -- "ctrl"         ACCEPT
  ("pace","agents","agent-b",D4) -- "chat"         status
  ("pace","agents","agent-b",D4,"a2a","task") -- "research-1"
                                                   findings
C publishes:
  ("pace","agents","agent-c",D4) -- "ctrl"         ACCEPT
  ("pace","agents","agent-c",D4) -- "chat"         status
  ("pace","agents","agent-c",D4,"a2a","task") -- "analysis-1"
                                                   results
~~~

Because each agent follows the others' agent prefixes, every agent
receives every other agent's tracks in `D4`; no per-track
subscriptions are needed.

1. A publishes OPEN (gen 0, B and C `invited`). B and C each publish
   ACCEPT, and A commits both in one UPDATE (gen 1).
2. A posts assignments on `chat`. The relay delivers each object once
   to B and once to C.
3. B publishes findings on `research-1` as they arrive, one group per
   research phase.
4. C reads B's findings as they arrive and publishes its analysis on
   `analysis-1`.
5. A follows both tracks, posts a summary on `chat`, and publishes
   TERMINATE (gen 2). Each agent then ends its dialog tracks with
   PUBLISH_DONE.

## Group Chat with an AutoGen Runtime

An AutoGen {{AutoGen}} runtime, R, hosts a group chat with a human, H,
and a remote agent, B. AutoGen has no binding of its own, so R uses the
generic binding ({{jsonrpc-binding}}) with `"autogen"` as the protocol
name, and each AutoGen message carries the dialog reference in its
`metadata` ({{carrying-dialog-context}}).

~~~
R publishes:
  ("pace","agents","runtime-r",D5) -- "ctrl"       OPEN, UPDATE,
                                                   TERMINATE
  ("pace","agents","runtime-r",D5,"ext","autogen") -- "conv1"
                                                   R's agents' turns
H publishes:
  ("pace","agents","user-h",D5) -- "ctrl"          ACCEPT
  ("pace","agents","user-h",D5) -- "chat"          human input
B publishes:
  ("pace","agents","agent-b",D5) -- "ctrl"         ACCEPT
  ("pace","agents","agent-b",D5,"ext","autogen") -- "conv1"
                                                   B's turns
~~~

1. R opens `D5` (gen 0, H and B `invited`), and commits both ACCEPTs in
   one UPDATE (gen 1).
2. R's group chat manager picks the next speaker, as AutoGen does. The
   speaker's message goes out once on its publisher's `conv1` track,
   and the relay delivers it to every other participant.
3. When the manager asks the human, H answers on `chat`.
4. For a nested chat, R opens a child dialog `D6` whose
   `parent_dialog_ids` is `[D5]`, and posts its result back in `D5`.
5. R publishes TERMINATE (gen 2) when the chat ends.

# Acknowledgments

TODO
