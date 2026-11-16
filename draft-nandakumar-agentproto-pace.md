---
title: "PACE: Protocol for Agent Communication Exchange"
abbrev: "PACE"
category: std

docname: draft-nandakumar-agentproto-pace-latest
submissiontype: IETF
number:
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
  RFC6234:
  RFC7515:
  RFC7519:
  RFC7800:
  RFC8785:
  WPT-MSG:
    title: "Workload Proof Tokens for Message-Oriented Protocols"
    date: 2026-11
    author:
    - ins: S. Nandakumar
    - ins: C. Jennings
    seriesinfo:
      Internet-Draft: draft-nandakumar-wimse-wpt-message-binding-00
    target: https://datatracker.ietf.org/doc/draft-nandakumar-wimse-wpt-message-binding/
  RFC2119:
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
  WIMSE-WPT: I-D.ietf-wimse-wpt
  ACTOR-PROFILE: I-D.mcguinness-oauth-actor-profile
  DELEGATION-TOKENS: I-D.asor-wimse-agent-delegation-chain
  AGENT-DELEGATION:
    title: "Delegator-Bound Delegation Chains for AI Agents"
    date: 2026-11
    author:
    - ins: S. Nandakumar
    - ins: C. Jennings
    seriesinfo:
      Internet-Draft: draft-nandakumar-wimse-delegator-bound-chains-00
    target: https://datatracker.ietf.org/doc/draft-nandakumar-wimse-delegator-bound-chains/
  OAUTH-2.1: I-D.ietf-oauth-v2-1
  RFC8693:
  RFC9635:
  WEBTRANS-H3: I-D.ietf-webtrans-http3
  PACE-HTTP:
    title: "PACE over HTTP: Agent Dialog Management for HTTP Applications"
    date: 2026-11
    author:
    - ins: S. Nandakumar
    - ins: C. Jennings
    seriesinfo:
      Internet-Draft: draft-nandakumar-agentproto-pace-http-00
    target: https://datatracker.ietf.org/doc/draft-nandakumar-agentproto-pace-http/
  PACE-OIDC:
    title: "Using OpenID Connect with Agent Dialogs"
    date: 2026-11
    author:
    - ins: S. Nandakumar
    - ins: C. Jennings
    seriesinfo:
      Internet-Draft: draft-nandakumar-agentproto-oidc-profile-00
    target: https://datatracker.ietf.org/doc/draft-nandakumar-agentproto-oidc-profile/
  RFC9449:
  RFC9576:
  MOQ-PP: I-D.ietf-moq-privacy-pass-auth
  PP-AGENTS:
    title: "Privacy Pass for Delegated Agents: Delegation Attestation and Holder-Bound Tokens"
    date: 2026-11
    author:
    - ins: S. Nandakumar
    - ins: C. Jennings
    seriesinfo:
      Internet-Draft: draft-nandakumar-privacypass-delegated-agents-00
    target: https://datatracker.ietf.org/doc/draft-nandakumar-privacypass-delegated-agents/
  RFC9901:
  MOQ-SECURE-OBJECTS: I-D.ietf-moq-secure-objects
  PACE-MLS:
    title: "End-to-End Keys for PACE Dialogs Using MLS"
    date: 2026-11
    author:
    - ins: S. Nandakumar
    - ins: C. Jennings
    seriesinfo:
      Internet-Draft: draft-nandakumar-agentproto-pace-mls-00
    target: https://datatracker.ietf.org/doc/draft-nandakumar-agentproto-pace-mls/
  TRAIL: I-D.nassar-agentproto-trail
  PACE-AUTHZ:
    title: "PACE Authorization: Delegation and Action Approval"
    date: 2026-11
    author:
    - ins: S. Nandakumar
    - ins: C. Jennings
    seriesinfo:
      Internet-Draft: draft-nandakumar-agentproto-pace-authz-00
    target: https://datatracker.ietf.org/doc/draft-nandakumar-agentproto-pace-authz/
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
  MCP-MOQT: I-D.jennings-agentproto-mcp-over-moqt
  RFC9396:
  CIMD: I-D.ietf-oauth-client-id-metadata-document
  DIALOG-UC:
    title: "Agentic Dialog Use Cases"
    date: 2026-11
    author:
    - ins: F. Siyavud
  PACE-TEL:
    title: "PACE for Telephony: Agent Dialogs over SIP and the PSTN"
    date: 2026-11
    author:
    - ins: S. Nandakumar
    - ins: C. Jennings
    seriesinfo:
      Internet-Draft: draft-nandakumar-agentproto-pace-telephony-00
    target: https://datatracker.ietf.org/doc/draft-nandakumar-agentproto-pace-telephony/
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
their own extension points. Delegation between agents and approval of
individual agent actions are specified in a companion document.

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
The authority agents exercise in a dialog, delegating work and
approving single actions, is specified in PACE Authorization
{{PACE-AUTHZ}}.
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
  corresponds to the meta-data of the {{ARCH}} dialog context.

Log:
: The content of a dialog: the inputs and outputs its participants
  exchange, as an ordered sequence of log entries per flow
  ({{dialog-log}}). It corresponds to the log of the {{ARCH}} dialog
  context. Entry content is opaque to PACE; entry metadata is not.

Flow:
: An ordered sequence of log entries that one participant sends in a
  dialog, with a single output class and delivery class, such as one
  participant's chat or audio. A binding defines how flows are named;
  in the MOQT binding, a flow is a track ({{log-over-moqt}}).

Log position:
: A value that orders the entries of one flow. Positions increase
  with each entry but need not be contiguous.

Dialog identifier (dialog-id):
: A UUID that names a dialog for its whole lifetime.

Participant:
: A user-facing client, agent, tool, or service that takes part in a
  dialog and processes its dialog context. Each participant has a
  participant identifier that is unique within the dialog. In the
  MOQT binding, the participant identifier is the agent-id field of
  the participant's tracks in the dialog namespace ({{namespace}}). A participant plays the
  principal or agent role of {{ARCH}}; the controller is usually the
  principal's client.

Principal:
: The user, workload, or organization on whose behalf a dialog runs
  and from whom an agent's authority derives, corresponding to the
  principal role of {{ARCH}}. A principal takes part through a
  participant, usually its client, or through an agent that acts for
  it; in a credential, the principal is the subject, not the agent
  presenting it ({{identity-discovery}}).

Controller:
: The participant named by `controller_id` in the dialog context:
  initially the participant that opened the dialog, later an alternate
  controller that took over ({{controller-transfer}}). The controller
  is the authoritative source of the dialog context and the only
  participant that changes the participant set, expiration,
  generation, or terminal state.

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

Participant descriptor:
: Optional members of a participant's entry in the dialog context that
  say what kind of party it is, whom it acts for, how it was
  authenticated and by whom, what it may receive, and what it has
  consented to ({{participant-descriptors}}).

Posture:
: Whether a participant treats the dialog as cooperative or
  adversarial ({{posture}}). Posture describes incentives, not
  hostility {{DIALOG-UC}}.

Segment:
: A span of a dialog whose content reaches only named participants,
  while the others learn that it happened and its result
  ({{segments}}).

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
ones, are left to the application. PACE over HTTP {{PACE-HTTP}} binds
the same dialogs to HTTP/1.1, HTTP/2, and HTTP/3 for agents that cannot
use MOQT, states which of these requirements each HTTP version meets,
and moves real-time media to MOQT over WebTransport.

## Why MOQT?

This document specifies a MOQT binding for exchanging dialogs;
{{PACE-HTTP}} specifies an HTTP binding that interoperates with it. Media
over QUIC Transport (MOQT) {{MoQ-TRANSPORT}} is a publish/subscribe
protocol over QUIC {{RFC9000}}. It meets each requirement in
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
  participants and flows appear without a separate signaling channel. Output
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

## Overview {#dialog-overview}

A dialog has one controller, which holds the authoritative dialog
context: the dialog's identifier, its state, its participants and
their states, and a generation number. Other participants read that
context and send requests; only the controller changes it.

Every change works the same way. A participant sends a request, such
as ACCEPT to answer an invitation, LEAVE, or DECLARE to state what
kind of party it is. The controller decides whether to apply it and,
if it does, publishes UPDATE with the complete new context at the next
generation. Receivers replace their copy of the context with each
UPDATE instead of merging changes, and use the generation to detect a
missed or stale update ({{generations}}).

The dialog is `pending` until an invitee accepts, then `active`, and
finally `terminated` ({{lifecycle}}). Each participant has its own
state: `invited`, then `active`, and then `left`, `rejected`, or
`revoked` ({{participant-states}}). A participant leaving does not by
itself end the dialog.

A two-party dialog opens as follows:

~~~
  A (controller)                                         B
    |  OPEN    gen 0, pending, A active, B invited        |
    |---------------------------------------------------->|
    |  ACCEPT  in_reply_to: the OPEN                      |
    |<----------------------------------------------------|
    |  UPDATE  gen 1, active, A active, B active          |
    |---------------------------------------------------->|
    |                                                     |
    |      content: entries of the dialog log             |
    |<===================================================>|
~~~
{: #figure-dialog-overview title="Opening a Two-Party Dialog"}

The rest of this section defines, in order: the dialog context
({{dialog-context}}); the dialog and participant states, the control
operations, and how the controller commits changes ({{lifecycle}});
what participants declare and how they are admitted and removed
({{participants}}); negotiated parameters ({{dialog-parameters}});
stopping work and ending dialogs ({{ending}}); segments, delegated
dialogs, and controller changes ({{delegated-work}}); errors
({{errors}}); recovery after an interruption ({{propagation}}); the
encoding of control messages ({{control-encoding}}); and the dialog log
({{dialog-log}}).

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

  A controller that opens a delegated dialog with participants in
  another trust domain MAY omit `parent_dialog_ids`, or list only the
  entries those participants may learn, so that parent dialog-ids are
  not disclosed across the boundary. It then keeps the link to the
  parent dialogs locally and applies lifecycle propagation
  ({{lifecycle-propagation}}) and cancellation ({{cancellation}}) from
  that local link. Participants of such a dialog cannot detect a
  cycle in the dialog lineage; they rely on the delegation chain in
  `credentials` for cycle detection ({{delegation}}).
* `related_dialogs`: An optional list of objects, each with a
  `dialog_id` and a `relation`, set by the controller in OPEN and
  unchanged after it. `relation` is `follow-up` (the dialog carries
  updates on the outcome of the named dialog after it ended),
  `resumes` (the dialog continues a relationship established in the
  named dialog), or `continues` (the dialog carries on the same task
  on another channel). Unlike `parent_dialog_ids`, a related dialog is
  not delegated work: lifecycle propagation ({{lifecycle-propagation}})
  and cancellation do not follow this link, so a follow-up outlives the
  dialog it follows. A controller MAY withhold entries across a trust
  boundary, as for `parent_dialog_ids`.
* `alternate_controller_id`: An optional participant identifier of an
  active participant that may take over as controller
  ({{controller-transfer}}).

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
expiration, `parent_dialog_ids` is omitted when the dialog was not
opened from another dialog or when the controller withholds it
(above), `related_dialogs` is omitted when there are none, and
`alternate_controller_id` is omitted
when no alternate is designated. A context snapshot MUST contain every other
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
JOIN_REQUEST, LEAVE and DECLARE are requests the controller commits with
UPDATE. Interruptions, cancellations, and segments do not change the state.

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
Resumption is STATE_REQUEST, which recovers the dialog context,
followed by LOG_STATUS, which establishes what each receiver has
accepted so that missed input and output are replayed without
duplication ({{log-replay}}), and cancellation is CANCEL
({{cancellation}}).

PACE defines the following control operations:

| Operation | Sender | Generation | Effect |
|---|---|---|---|
| OPEN | Controller | 0 | Creates a pending dialog and identifies invitees. |
| ACCEPT | Participant or invitee | Current | Accepts an invitation or a parameter proposal. |
| REJECT | Participant or invitee | Current | Rejects an invitation or a parameter proposal. |
| UPDATE | Controller | Next | Replaces the participant set, expiration, or controller. |
| JOIN_REQUEST | Prospective participant | Latest known, or 0 | Requests admission to an existing dialog. |
| LEAVE | Participant | Current | Leaves the dialog. The controller records the participant as left. |
| DECLARE | Participant | Current | Declares the sender's own descriptors, or its observations of others ({{declare}}). |
| REVOKE | Controller | Next | Revokes a participant's propagation relationship. |
| TERMINATE | Controller | Next | Ends the dialog. |
| SEGMENT | Controller | Current | Starts or ends a segment ({{segments}}). |
| CANCEL | Any participant | Current | Asks receivers to stop work started by the sender's earlier input ({{cancellation}}). |
| CANCEL_ACK | Any participant | Current | Reports the outcome of a CANCEL. |
| STATE_REQUEST | Participant | Current | Requests the current context after a gap or reconnection. |
| STATE | Controller | Current | Supplies a complete context snapshot. |
| LOG_STATUS | Any participant | Current | Reports accepted log positions, or answers such a report ({{log-replay}}). |
| ERROR | Any participant | Current | Reports that an operation was not applied, and why. |
{: #table-control-ops title="Control Operations"}

### Participant States {#participant-states}

Each entry in `participants` has its own state, separate from the
dialog state. The controller sets it, in the same UPDATE, REVOKE, or
OPEN that commits the change:

~~~
     named in OPEN, or added by UPDATE
     (an invitation or an admitted JOIN_REQUEST)
                      |
                      v
               +-------------+  REJECT committed   +------------+
               |   invited   |-------------------->|  rejected  |
               +-------------+                     +------------+
                      |
                      | ACCEPT committed
                      v
               +-------------+  LEAVE committed    +------------+
               |   active    |-------------------->|    left    |
               +-------------+                     +------------+
                      |
                      | REVOKE
                      v
               +-------------+
               |   revoked   |
               +-------------+
~~~
{: #figure-participant-states title="Participant State Machine"}

A participant in state `left`, `rejected`, or `revoked` stays in every
later snapshot with that state ({{dialog-context}}). Admission
({{guests}}, {{sponsored-admission}}, {{joining-codes}}) and revocation
({{revoking-a-participant}}) are defined in {{participants}}.

### Committing Participant Changes {#committing}

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

## Participants {#participants}

This section defines what participants declare about themselves and
others, and how they are admitted and removed. Each change is a
request that the controller commits with UPDATE ({{committing}}).

### Participant Descriptors {#participant-descriptors}

In a dialog between a person and their own agent, the participants
know who each other is. Many dialogs PACE carries are not like that
{{DIALOG-UC}}. A consumer's agent negotiates with a brand's agent; a
person on a phone call talks to a voice agent through a gateway; a
recorder or a transcriber joins a meeting. Before a participant shares
information or agrees to something, it needs answers to questions
such as:

* Is the other party a person or software?
* For whom does it act, and what may it commit to?
* How strongly was it authenticated, and by whom?
* Has it agreed to be recorded, or to have its input processed?
* Is it here to cooperate, or to bargain?

Policies, and in some places laws, on AI disclosure, recording
consent, and delegated authority depend on these answers.
Participant descriptors carry them in the dialog context, so that
every participant sees the same answers and knows who gave each one.

Each entry in `participants` MAY carry the members below. They come
from three sources: the participant itself, other participants, and
the controller. The source matters, because a participant's statement
about itself is not the same as another participant's observation of
it.

| Member | Set by | Value |
|---|---|---|
| `kind` | The participant | `human`, `agent`, `tool`, `transformer`, `recorder`, or `gateway` |
| `acts_for` | The participant | Opaque pseudonym of its principal |
| `commit_scope` | The participant | RAR `authorization_details` {{RFC9396}}: what it may commit to |
| `consent` | The participant | `{"recording": s, "processing": s}`; s is `granted`, `refused`, or `withdrawn` |
| `posture` | The participant | `cooperative` or `adversarial` ({{posture}}) |
| `detected_kind` | Other participants | List of `{"kind", "by", "how"}`; `by` is the observing participant, `how` is `stated` (the subject said so) or `inferred` |
| `observed_consent` | Other participants | List of `{"recording", "processing", "by", "how"}`, for a participant that cannot declare its own, such as a person on a call |
| `assurance` | Other participants | List of `{"level", "by", "method", "at"}` |
| `access` | Controller | `{"send": [...], "receive": [...]}`, naming modalities or flows |
| `declaration_ref` | Controller | `message_id` of the DECLARE whose values were committed |
| `sponsor` | Controller | Participant that sponsored this participant's admission ({{sponsored-admission}}) |
{: #table-descriptors title="Participant Descriptors"}

Declared members:
: The controller copies them verbatim from the participant's latest
  DECLARE and names that DECLARE in `declaration_ref`. Any participant
  can check the copy against the DECLARE the sender published, which
  is authenticated by the sender's key-bound presentation
  ({{key-binding}}). A controller MUST NOT alter them. A participant
  that finds a mismatch MUST disregard the controller's copy.

Observed members:
: Each entry names the participant that made it, in `by`, so that
  every participant decides for itself whether to rely on it. This is
  what separates a participant's claim to be a person (`kind`) from
  another participant's detection of automation (`detected_kind`).

`assurance`:
: How strongly a participant was authenticated. `level` is `none` (a
  guest, not authenticated), `asserted` (identity claimed but not
  verified), `authenticated`, or `delegated` (authenticated, with
  verified authority from a principal). `method` is a value from the
  PACE Assurance Methods registry ({{iana}}): `credential`, a
  key-bound presentation ({{key-binding}}) of a credential mechanism
  ({{identity-formats}}); `cimd`, a key-bound presentation checked
  against a key from an OAuth Client ID Metadata Document {{CIMD}};
  `resumed`, keys pinned in an earlier dialog named in
  `related_dialogs` with relation `resumes`; or `join-code`
  ({{joining-codes}}). Other documents register further methods, such
  as those for telephony {{PACE-TEL}}.

`access`:
: What the participant may send and receive, such as audio but not
  screen share. It differs from the `supported_modalities` parameter,
  which states what a participant can handle. Absent `access`, a
  participant may send and receive every flow. Relays and dialog hosts
  enforce it ({{relay-authorization}}).

An example entry, for a consumer's agent as seen in a dialog with a
brand's agent:

~~~json
{"participant_id": "p-7c1e", "state": "active",
 "kind": "agent", "acts_for": "u-4f9a",
 "detected_kind": [{"kind": "agent", "by": "brand-agent"}],
 "assurance": [{"level": "delegated", "by": "brand-agent",
                "method": "credential", "at": "2026-11-13T10:02:11Z"}],
 "posture": "adversarial",
 "declaration_ref": "9b2f6c1e-0d4a-4e8b-a7c3-5f1d2e3a4b6c"}
~~~

### Declarations {#declare}

A participant states its own descriptors, and what it observed about
others, with DECLARE. DECLARE is a separate operation, rather than a
field the controller fills in, because the controller may act for the
other side. A brand's agent that controls a dialog should not be able
to say that the consumer's agent consented to recording, or that the
consumer's agent is a person. With DECLARE, the statement comes from
the participant and is signed by it; the controller only copies it,
and anyone can check the copy.

The `declaration` member of DECLARE is an object with any of these
members:

Own descriptors:
: `kind`, `acts_for`, `commit_scope`, `consent`, and `posture`. Each
  replaces the sender's previously declared value.

`sponsored`:
: A list of participant identifiers whose admission the sender
  sponsors ({{sponsored-admission}}).

`observations`:
: A list of objects, each with `subject` (a participant identifier),
  one or more of `detected_kind`, `assurance`, and `consent`, and
  optionally `how` (`stated` or `inferred`). Each states what the
  sender concluded about that participant, or what the participant
  said when it cannot declare for itself, such as a person on a call
  who agrees to be recorded.

`disclosure`:
: A record that the sender disclosed that it is an AI, with `at` (the
  time), `to` (the participant identifiers it was made to), and
  `entry` (the entry reference of the log entry that carried it). It
  records what the sender said, not that it was understood.

The controller commits a DECLARE with UPDATE at the next generation.
In that UPDATE, it:

1. copies the sender's own values into the sender's entry and sets
   `declaration_ref`; and
2. appends each observation to the subject's `detected_kind`,
   `assurance`, or `observed_consent`, with `by` set to the sender. An
   observed consent never replaces a participant's own `consent`
   declaration.

The controller MUST commit a well-formed DECLARE from an active
participant without undue delay. It MUST NOT refuse a declaration of
`kind`, a raise of `posture`, or a `consent` value of `refused` or
`withdrawn`. A participant must be able to say what it is, to become
more cautious, and to refuse recording, without the agreement of a
controller that may act for its adversary. A controller MAY refuse other declarations with ERROR
`policy-rejected`.

### Posture {#posture}

Many agent dialogs are between parties whose interests differ: a
buyer's agent and a seller's agent, or a customer's agent and a
support agent handling a dispute. In such a dialog, an agent should
not share everything it knows about its principal, and should not rely
on the other side's statements without checking them. Posture lets a
participant say which kind of dialog it considers this to be, so that
every participant applies the matching policy and knows that the
others have been told. Posture describes incentives, not hostility.

A participant declares its posture with DECLARE:

* The dialog's effective posture is `adversarial` if any active
  participant declares it, and `cooperative` otherwise.
* Each participant decides from its own policy what posture means for
  it, such as whether a routine exchange may proceed without a
  per-action approval ({{delegation-approval}}).
* A counterpart's declaration of `cooperative` MUST NOT lower the
  assurance, approvals, or records that a participant's policy
  requires.

A participant can raise its posture at any point, for example when an
order-status inquiry turns into a refund dispute. The controller
commits the change like any declaration and cannot refuse it
({{declare}}), so every participant learns of it. Context shared
before the change stays shared; after it, participants SHOULD stop
sharing context they would not give an adversary, and each applies its
adversarial policy to later exchanges.

### Guests and Assurance Upgrade {#guests}

A controller MAY admit a participant that has not authenticated, such
as a caller on a channel that carries no credential, and records its
`assurance` level as `none`. The deployment's policy limits what a
guest may do, such as receiving general information only. The
participant raises its level later in the same dialog by presenting
`credentials` on a later control message, such as a DECLARE; the
controller, or another participant that verifies them, records a new
`assurance` entry. No new dialog is needed. A participant that
requires a higher level for an operation rejects it with ERROR
`insufficient-assurance`, stating what it needs ({{error-reasons}}); a
participant that cannot or will not upgrade answers with ERROR
`upgrade-declined`, and the dialog continues at the current level.

### Sponsored Admission {#sponsored-admission}

In a dialog between parties of different principals, the controller
acts for one side, and the other side still needs to bring in its own
principal or a person who takes over from its agent. A JOIN_REQUEST
MAY carry `sponsor`, the identifier of an active participant. If that
participant has listed the requester in the `sponsored` member of its
latest committed declaration, the controller MUST admit the requester,
subject only to authenticating it and to `max_participants`, and MUST
NOT give it `access` narrower than the sponsor's. The controller sets
`sponsor` in the requester's entry. A principal takes over from its
agent by joining as the agent's sponsored participant, after which the
agent sends LEAVE.

### Join Codes {#joining-codes}

A participant on a channel that cannot carry the dialog identifier,
such as a voice call over the PSTN, can bind a new channel to the same
dialog with a join code: a short-lived, single-use value that the
controller issues to an existing participant and that is conveyed in
the call. A JOIN_REQUEST MAY carry `join_code`. If it is valid, the
controller admits the requester as the sponsored participant of the
participant to which the code was issued, records an `assurance`
entry with `method` `join-code`, and invalidates the code. A code
MUST have at least the entropy its lifetime and the controller's rate
limit on attempts require, and a controller MUST limit attempts per
dialog. A requester that does not know the dialog-id redeems the code
at an endpoint that resolves it, as {{PACE-HTTP}} defines. Encodings
for voice and DTMF are defined in {{PACE-TEL}}.

### Revoking a Participant {#revoking-a-participant}

REVOKE is controller-authoritative. It carries the complete context at
the next generation, sets the target participant's state to `revoked`,
and ends that participant's propagation relationship. A participant or
intermediary that receives REVOKE:

* MUST stop forwarding the dialog's context to the target.
* MUST cancel subscriptions that it holds only to propagate the dialog
  to the target.

The revoked participant MUST stop acting under the authorization it
held in the dialog. It MUST send TERMINATE in each delegated dialog it
controls whose `parent_dialog_ids` include the dialog, so that work
it delegated under that authorization stops as well
({{lifecycle-propagation}}). Revocation of the participant's
credential itself is a function of the credential mechanism
({{identity-formats}}).

## Dialog Parameters {#dialog-parameters}

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
* `liveness_interval`: Maximum interval, in seconds, between liveness
  signals from a participant doing work in the dialog ({{liveness}})
* `controller_capable`: Whether the participant can act as controller
  if designated as alternate ({{controller-transfer}})
* `log_retention`: Minimum time, in seconds, for which a participant
  retains entries of its `reliable` flows that a consumer has not yet
  accepted ({{log-replay}})
* `purpose`: On OPEN and JOIN_REQUEST, a short statement of why the
  sender opens or joins the dialog, such as a delivery update or a
  notetaker for a meeting
* `basis`: On OPEN and JOIN_REQUEST, why the sender considers itself
  entitled to make contact, from the PACE Contact Basis registry
  ({{contact-basis}})

Parameters are negotiated by proposal and acceptance:

* The controller proposes values in OPEN, or in UPDATE for a change.
* Each invitee or participant accepts with ACCEPT, stating the values
  it supports. A participant that cannot accept a proposal sends
  REJECT.
* For list-valued parameters, such as `supported_modalities` and
  `supported_protocols`, the accepted values MUST be a subset of the
  proposed ones, and they are the participant's active set. Accepting
  no value of `supported_modalities` is a rejection.
* For scalar parameters, the accepted value MAY lower a limit
  (`max_participants`, `idle_timeout`, `liveness_interval`) but MUST
  NOT raise it. `log_retention` is a minimum, so the accepted value
  MAY raise it but MUST NOT lower it.
* `purpose` and `basis` are not negotiated.
* The controller's committing UPDATE carries the resulting values in
  `parameters`, and those values are in effect from that generation.

### Contact Purpose and Basis {#contact-basis}

An agent can open a dialog with a party that did not ask for it, such
as a person's agent or an organization's inbox. The recipient needs to
decide whether to engage before any content is exchanged, as a person
screens a call or an email {{DIALOG-UC}}. `purpose` says what the
contact is about, and `basis` says why the sender considers itself
entitled to make it. With `contact_limits` ({{results}}), they let a
recipient refuse a contact, say why, and limit later ones.

`basis` takes one of these values:

`subscription`:
: The recipient asked for contacts of this kind, such as updates on an
  order or a delivery.

`existing-relationship`:
: The sender and the recipient's principal have an ongoing
  relationship, such as a customer account, and the contact concerns
  it.

`contract`:
: The contact is needed to carry out an agreement to which the
  recipient's principal is a party, such as arranging the delivery of
  something it bought.

`legal-obligation`:
: Law or regulation requires the sender to make the contact, such as a
  product safety recall.

`consent`:
: The recipient's principal agreed to contacts of this kind from this
  sender, outside any subscription.

`none`:
: The sender claims no basis: the contact is unsolicited, and says so.

`purpose` and `basis` are the sender's assertions, and the recipient
checks them. A recipient can check `subscription`, and often
`existing-relationship` and `consent`, against its own records. It
cannot in general check `contract` or `legal-obligation`; it records
them and weighs them with the sender's `assurance`
({{participant-descriptors}}). A recipient can refuse a contact whose
basis it cannot confirm, or that states no `purpose` or `basis`, with
REJECT and a `result` reason such as `unwanted-contact` or
`no-stated-purpose` ({{results}}). The values describe the sender's
reason for making contact; they are not claims of a legal basis for
processing personal data under any jurisdiction.

### Dialog Lifetime {#dialog-lifetime}

Short-lived dialogs carry an `expires_at` in the dialog context and end
when it passes. Long-lived dialogs omit `expires_at` and continue
across idle periods and interruptions until the controller terminates
them. When `idle_timeout` is set and the dialog has been idle for that
long, with no content or control sent by any participant, the
controller SHOULD publish TERMINATE.

## Stopping Work and Ending Dialogs {#ending}

CANCEL stops work without ending the dialog ({{cancellation}});
TERMINATE and expiry end it ({{termination}}); and results say how a
participant regards the outcome ({{results}}).

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
* `partially-reversed`: the work stopped, and some but not all of the
  actions it took were rolled back.
* `irreversible`: the work stopped, but an action it took could not be
  rolled back.
* `unknown`: the receiver cannot determine whether the work, or work
  it delegated, stopped.

CANCEL_ACK MAY also carry `compensation`, an object with a
`description` and an opaque `reference`, for what the receiver offers
in place of an action it could not reverse, such as a refund or a
credit. The terms under which work can be cancelled before it commits
are stated in a commitment ({{delegation-approval}}).

When CANCEL reaches delegated dialogs (scope `subtree` or `dialog`), a
receiver that controls such dialogs sends its own CANCEL_ACK only
after it has received a CANCEL_ACK from each participant doing work in
them, or after a locally configured timeout. Its outcome is the least
favorable among its own and those it received, in the order
`completed`, `stopped`, `partially-reversed`, `irreversible`,
`unknown`; a delegated participant that did not answer before the
timeout counts as `unknown`. The initiator of a CANCEL therefore
learns whether the cancellation took effect along the whole chain, or
that this could not be determined.

Such a receiver MAY also report each delegate's outcome in `details`,
a list of objects with `delegate`, `outcome`, and optionally
`dialog_id` and `compensation`. `delegate` is the delegate's
participant identifier, or an opaque label where the receiver withheld
the delegated dialog from the initiator ({{dialog-context}}); in that
case `dialog_id` is omitted. A delegate that did not answer is listed
with `unknown`.

### Termination and Expiry {#termination}

TERMINATE is final.

* After TERMINATE, a receiver MUST reject later operations for the
  dialog with ERROR `dialog-terminated`, except a duplicate TERMINATE
  or a STATE needed to complete synchronization.
* Expiration has the same effect as TERMINATE. Each participant
  evaluates it locally from `expires_at`, and it does not create a new
  generation.
* A controller SHOULD publish TERMINATE before the expiration time when
  it can.
* Resuming a transport connection does not reopen a terminated or
  expired dialog.

### Results and Contact Limits {#results}

ERROR reports that an operation failed. A dialog that ends normally
can still end without what a participant wanted: a refund declined,
an agreement not reached, a contact refused. TERMINATE, LEAVE, and
REJECT MAY carry `result`, which states how the sender regards the
dialog's outcome:

~~~json
"result": {
  "category": "deferred",
  "reason": "policy",
  "next_update_at": "2026-11-20T09:00:00Z",
  "recourse": "https://brand.example/disputes",
  "parts": [{"label": "pickup", "category": "completed",
             "compensable": false},
            {"label": "refund", "category": "deferred",
             "compensable": true}],
  "sources": ["a1b2c3d4-..."],
  "commitments": ["6f1c0e9a-..."]
}
~~~

* `category`: REQUIRED. One of `completed`, `declined`, `deferred`,
  `partial`, `transferred`, `failed`, or `abandoned`.
* `reason`: OPTIONAL. A value from the PACE Result Reasons registry
  ({{iana}}), such as `ineligible`, `suspected-fraud`, or
  `no-stated-purpose`.
* `retry_after`: OPTIONAL. The time before which the recipient
  should not ask again.
* `recourse`: OPTIONAL. A URI at which the recipient can pursue the
  matter, such as an appeal or a human channel.
* `next_update_at`: OPTIONAL. For `deferred`, when the sender expects
  to report next, so that a waiting participant does not poll.
* `parts`: OPTIONAL. For `partial`, the outcome of each part, and
  whether a part that took effect can be compensated.
* `sources` and `commitments`: OPTIONAL. Identifiers of attested
  assertions and commitments ({{delegation-approval}}) on which the result rests,
  so that each fact keeps its source.

`result` is the sender's statement. It does not change the dialog
state beyond the operation it accompanies, and a participant that
needs to rely on it checks the assertions and commitments it cites.

REJECT, LEAVE, and TERMINATE MAY also carry `contact_limits`, which
asks the recipient to limit further contact:

* `retry_after`: The time before which the recipient does not contact
  the sender again.
* `max_contacts` and `period`: At most `max_contacts` contacts in
  any `period` seconds.
* `scope`: `dialog`, for dialogs related to this one, or `sender`,
  for any dialog from the same sender.
* `opt_out`: When true, the sender refuses further contact of this
  kind altogether; later contacts are refused with ERROR
  `unwanted-contact`.

Limits apply to the recipient as identified by its `credentials`.
They cannot be tied to a participant that has not authenticated
({{guests}}). They are enforced by the sender's own policy; a
recipient that ignores them is refused.

## Segments, Delegated Dialogs, and Controller Changes {#delegated-work}

These rules apply to dialogs whose content some participants may not
see ({{segments}}), dialogs opened to carry out work delegated from
another dialog ({{lifecycle-propagation}}, {{liveness}}), and dialogs
whose controller changes ({{controller-transfer}}).

### Segments {#segments}

Part of a dialog sometimes has to reach only some participants: card
details entered for a payment tool, an off-the-record span in a
meeting, or a challenge that only the person behind an agent may
answer {{DIALOG-UC}}. A dialog has one visibility scope
({{topologies}}), so the content of such a segment is exchanged in a
separate dialog whose `parent_dialog_ids` names this one, and whose
participants are only those who may see it. This dialog, the parent,
carries only the segment's start, end, and result.

The controller announces a segment with SEGMENT. Its `segment`
member has:

* `segment_id`: A UUID version 4.
* `kind`: `masked`, for content delivered only to the named
  participants, such as payment data, or `off-the-record`, for a span
  that agents and recorders do not receive.
* `phase`: `start` or `end`.
* `participants`: The participants that receive the segment's
  content.
* `dialog_id`: OPTIONAL. The dialog that carries the content. The
  controller MAY withhold it from participants not listed.
* `result` and `reference`: OPTIONAL, on `end`. The segment's result
  ({{results}}) and an opaque reference to it, such as a payment
  reference, that does not expose its content.

Each participant not listed in `participants` MUST acknowledge a
SEGMENT with ACCEPT naming it in `in_reply_to`. A `recorder` records
the gap, so its record shows that a segment happened, its kind, and
its result. For `off-the-record`, the controller MUST NOT admit to the
segment dialog any participant whose `kind` is `agent` or `recorder`,
and the segment's participants exchange its content only in the
segment dialog. Until a participant has acknowledged, it might not know
that a gap is intended; the controller MAY revoke a participant that
does not acknowledge, and a dialog host withholds later content from it
{{PACE-HTTP}}.

Because the segment dialog is a delegated dialog of this one, it ends
when this one ends ({{lifecycle-propagation}}). With end-to-end
protection ({{e2e-protection}}), it has its own keys, so participants
of this dialog that are not in the segment cannot read its content
even through the relays they share.

### Lifecycle Propagation Along Delegation Chains {#lifecycle-propagation}

A delegated dialog carries out work for the dialogs listed in its
`parent_dialog_ids`. Its lifecycle follows theirs:

* When a dialog terminates or expires, each participant that controls
  a delegated dialog whose `parent_dialog_ids` include it MUST send
  TERMINATE in that delegated dialog. Termination therefore reaches
  the end of the delegation chain, as CANCEL with scope `subtree` does
  ({{cancellation}}).
* When a participant is revoked, it terminates the delegated dialogs
  it controls under that participation ({{revoking-a-participant}}).
* A controller that terminates a delegated dialog for one of these
  reasons and needs to know whether work below it stopped first sends
  CANCEL with scope `dialog` and waits for the CANCEL_ACK outcomes
  ({{cancellation}}).

These rules use only the linkage in `parent_dialog_ids`, or the
controller's local link when it withheld that member
({{dialog-context}}). A participant
that cannot reach a delegated dialog's other participants still
terminates it; they observe the termination when they resynchronize.

### Liveness {#liveness}

When the `liveness_interval` parameter is set, a participant that is
doing work in the dialog for another participant publishes a liveness
signal at least once per interval, even when it has no other output.
In the MOQT binding, the signal is an object on its `progress` track
({{dialog-namespace}}); any other object the participant publishes in
the dialog also counts.

If a delegating participant receives no liveness signal from a
delegated participant for two consecutive intervals, it treats that
participant as unavailable: it halts the affected work, sends CANCEL
for it, and MAY ask the controller to revoke the participant.
Unavailability is not revocation; it can be a transient failure, and
the participant can resume ({{propagation}}).

### Controller Transfer {#controller-transfer}

A dialog's controller can change in two ways. In both, the new
controller is the participant named in `alternate_controller_id`,
which the controller sets with UPDATE and which MUST name an `active`
participant that set `controller_capable` in its ACCEPT `parameters`.

* Hand-off: The controller publishes UPDATE at the next generation
  with `controller_id` set to the alternate. From that generation, the
  alternate is the controller and the former controller is an ordinary
  participant.
* Takeover: If the controller is unreachable ({{propagation}}) for
  longer than the deployment's takeover time, the alternate publishes
  UPDATE at the next generation after the last one it accepted, with
  itself as `controller_id`, and with `credentials` showing that it is
  authorized to control the dialog, such as a delegation from the
  principal that authorized the original controller.

Participants accept a takeover UPDATE only from the participant named
in `alternate_controller_id` in the context they hold, and only after
verifying its credentials. If a participant receives two different
contexts for the same generation, one from the former controller and
one a takeover by the alternate, it MUST accept the takeover. A
participant that has already accepted a later generation from the
former controller rejects the takeover with ERROR `stale-generation`;
an alternate that receives this withdraws, resynchronizes with
STATE_REQUEST, and does not act as controller. A former controller
that sees an accepted context naming another controller MUST stop
publishing state-changing operations and resynchronize with
STATE_REQUEST.

Controller transfer keeps the dialog-id and generation sequence, so a
dialog continues through the failure of a controller, including an
application-level mediator that controls it, rather than being
replaced.

Editor's note: Takeover by an alternate trades availability for the
risk of a brief split between controllers. Deployments that cannot
tolerate this omit `alternate_controller_id`.

## Authorization and Errors {#errors}

Before applying an operation, a participant MUST authenticate its
sender and check authorization using the deployment's mechanisms
({{authorization}}). A valid state-changing operation needs no separate
acknowledgment. An ERROR names the rejected control message in
`in_reply_to`, or the rejected application operation in `target`
({{error-reasons}}), and gives a reason.

* A message that cannot be parsed, or that lacks a required member
  ({{control-encoding}}), is rejected with ERROR `malformed`.
* If the sender's credential is missing or fails verification, the
  participant MUST reject the operation with `unauthenticated`, or
  with `credential-invalid` when the credential is revoked or expired.
* If authorization fails or cannot be determined, the participant MUST
  reject the operation with ERROR, giving `unauthorized` or
  `authorization-unavailable` as the reason, or `scope-exceeded` when
  the operation exceeds the scope delegated to the sender.
* A participant that does not understand the control-message version
  or an operation MUST NOT reinterpret it. It responds with ERROR,
  giving `unsupported-version` or `unsupported-operation`.

Reasons are precise enough for the sender to decide what to do next,
but an ERROR MUST NOT reveal policy details beyond the reason.

### Error Reasons {#error-reasons}

The `reason` member of ERROR takes one of the values below. They
distinguish validation, authentication, authorization, policy, state,
and processing failures from transport failures, which MOQT reports
separately ({{Section 6.1.5 of ARCH}}).

| Reason | Meaning |
|---|---|
| `malformed` | The message cannot be parsed or lacks a required member. |
| `unsupported-version` | The control-message version is not supported. |
| `unsupported-operation` | The operation type is not supported. |
| `stale-generation` | The generation is older than the latest accepted. |
| `unauthenticated` | The sender's credential is missing or fails verification. |
| `credential-invalid` | The sender's credential is revoked, expired, or otherwise invalid. |
| `unauthorized` | The sender is not authorized for the operation. |
| `authorization-unavailable` | Authorization could not be determined at this time. |
| `scope-exceeded` | The operation exceeds or contradicts the scope delegated to the sender. |
| `policy-rejected` | Local policy refuses the operation, such as a join. |
| `delegation-cycle` | The delegation chain or dialog lineage contains a cycle ({{delegation}}). |
| `dialog-terminated` | The dialog is terminated or expired. |
| `participant-revoked` | The sender has been revoked from the dialog. |
| `validation-failed` | The operation was refused because it could cause unintended or irreversible effects. |
| `insufficient-assurance` | The sender's assurance is below what the operation needs; ERROR carries `required_assurance` ({{guests}}). |
| `upgrade-declined` | The sender cannot or will not raise its assurance; the dialog continues at the current level. |
| `unwanted-contact` | The recipient refuses contact from the sender ({{results}}). |
| `translation-failed` | A mediator could not translate the operation or its result between protocols. |
| `timeout` | The operation, or a step it depends on, did not complete in time. |
| `internal-error` | The receiver failed while processing the operation. |
{: #table-error-reasons title="ERROR Reasons"}

The first group of reasons applies to control messages. A participant
that rejects an application operation, such as a mediator that
refuses or cannot translate a tool call, also MAY publish ERROR with
`target` naming the operation, in the form CANCEL uses
({{cancel-over-moqt}}), and SHOULD also answer in the application
protocol where that protocol has a matching error.

Errors that the application protocol reports for its own operations,
such as a failed tool call (an MCP error result) or a failed task (an
A2A task in the `failed` state), stay in that protocol. A participant
can therefore tell a transport failure (MOQT), a dialog failure
(PACE ERROR), and a tool or agent processing failure (application
protocol) apart by where each is reported.

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
  changed while it was disconnected, and it uses LOG_STATUS to
  establish which log entries were accepted ({{log-replay}}).
  Acceptance of an entry does not imply that the application operation
  it carries completed; entries a receiver has not accepted are
  replayed, and entries it has accepted are not.
* Unreachability: If the controller is unreachable, participants MUST
  suspend actions that depend on an unconfirmed context change. Each
  participant remains at the last generation it accepted until the
  controller is reachable again, an alternate controller takes over
  ({{controller-transfer}}), or the dialog expires. Participants MUST NOT create
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
  or rejected, of the CANCEL being acknowledged, of the STATE_REQUEST
  being answered, or of the control message an ERROR rejects.
* `target_id`: The participant identifier whose propagation relationship
  is revoked.
* `declaration`: The sender's declaration ({{declare}}).
* `segment`: The segment being started or ended ({{segments}}).
* `scope`: The cancellation scope: `operation`, `subtree`, or `dialog`
  ({{cancellation}}).
* `target`: The operation to cancel when `scope` is `operation`, or the
  application operation an ERROR rejects. Its form is defined by the
  transport binding ({{cancel-over-moqt}}).
* `outcome`: One of `stopped`, `completed`, `partially-reversed`,
  `irreversible`, or `unknown`.
* `last_accepted_generation`: The highest generation the sender has
  accepted from the controller, or -1 if it has accepted none.
* `reason`: One of the values in {{table-error-reasons}}.
* `positions`: A list of objects, each with `sender_id`, `flow`, and
  `accepted`, giving the accepted position for one flow
  ({{log-acceptance}}). The forms of `flow` and `accepted` are
  defined by the binding.

Each type requires the members listed below:

| Type | Required type-specific members |
|---|---|
| OPEN | `context` |
| ACCEPT | `in_reply_to` |
| REJECT | `in_reply_to`; `reason` optional |
| UPDATE | `context` |
| JOIN_REQUEST | none |
| LEAVE | none |
| DECLARE | `declaration` |
| REVOKE | `target_id`, `context` |
| TERMINATE | `context` |
| SEGMENT | `segment` |
| STATE_REQUEST | `last_accepted_generation` |
| STATE | `context`; `in_reply_to` when answering a STATE_REQUEST |
| LOG_STATUS | `positions`; `in_reply_to` when answering a LOG_STATUS |
| CANCEL | `scope`; `target` when `scope` is `operation` |
| CANCEL_ACK | `in_reply_to`, `outcome` |
| ERROR | `reason`; `in_reply_to` or `target` |

For OPEN, `context` has generation 0 and state `pending`, and carries
`parent_dialog_ids` when the dialog is delegated. For UPDATE,
REVOKE, and TERMINATE, `context` has the next generation, and a
TERMINATE context has state `terminated`. An UPDATE that adds a
participant sets that participant's state to `invited`; the
participant becomes `active` only after it accepts and the controller
publishes a later UPDATE.

Further optional members are defined for some types:

* `result` and `contact_limits`: On TERMINATE, LEAVE, and REJECT
  ({{results}}).
* `required_assurance`: On ERROR with reason `insufficient-assurance`,
  an object with `level` ({{participant-descriptors}}) and optionally
  `acr_values` and `max_age` with their OpenID Connect meanings, for
  the authentication of the sender's principal.
* `sponsor` and `join_code`: On JOIN_REQUEST
  ({{sponsored-admission}}, {{joining-codes}}).
* `compensation` and `details`: On CANCEL_ACK ({{cancellation}}).

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
* `nonce`: On OPEN, ACCEPT, UPDATE, JOIN_REQUEST, STATE_REQUEST, and
  STATE, a fresh random value, with at least 128 bits of entropy and
  base64url-encoded, to which the recipient binds the presentation in
  its next `credentials` ({{key-binding}}).

JSON member order is insignificant. Receivers MUST ignore unrecognized
optional members, MUST reject an unrecognized `type`, and MUST reject
messages with missing required members, invalid member types, or an
unsupported version. Receivers MUST limit the size of a control message
to a locally configured maximum. A participant MUST NOT include
application content in a control message.

## Dialog Log {#dialog-log}

The dialog context tells participants which dialog they are in and
what state it is in. The log tells them what has been said in it.
PACE does not interpret log content, but it defines the metadata of
each log entry, so that participants can agree on what was exchanged
when they resume, recover, or start a new client instance
({{Section 4.2.10 of ARCH}}).

### Log Entries {#log-entries}

Each log entry has the following metadata:

* `sender_id`: The participant identifier of the sender.
* `flow`: The flow that carries the entry. Its form is defined by the
  binding.
* `position`: The entry's log position in that flow. Its form is
  defined by the binding. A sender MUST assign positions that increase
  with each entry it sends on a flow and MUST NOT reuse a position for
  different content.
* `timestamp`: Optionally, the time at which the sender produced the
  entry. Receivers MUST NOT rely on timestamps from different senders
  being comparable.

* `source_id`: Optionally, for an entry that renders another
  participant's input, such as a translation or a transcription, the
  participant identifier of the participant whose input it renders.
* `derived_from`: Optionally, the entry references of the entries it
  was derived from.

`sender_id`, `flow`, and `position` together form an entry
reference, which names one entry for the lifetime of the dialog.

A transformer, such as an interpreter or a speech-to-text gateway,
is a participant ({{participant-descriptors}}). It publishes each
rendering on a flow of its own, so that different participants receive
different renderings of the same exchange by choosing which flow to
consume, and records are kept with the original apart from its
renderings. Its renderings carry `source_id` and `derived_from`, so
they are attributed to the speaker as derived content and not
mistaken for the speaker's own words. Content a transformer sends that
renders no input, such as a note of its own, carries neither member and
is attributed to the transformer. PACE cannot check that a rendering
is faithful; it keeps each rendering linked to its source.

Each flow has an output class and a delivery class, fixed for the
life of the flow and defined by the binding's flow naming:

* Output class ({{Section 4.2.11 of ARCH}}): `input`, for content a
  participant sends in the principal role; `response`;
  `information`, such as tool calls, sub-agent invocations, and
  reasoning summaries; or `progress`, such as token counts, elapsed
  time, and liveness signals.
* Delivery class: `reliable`, for content that every receiver needs,
  such as chat, operations, and their results; or `loss-tolerant`, for
  real-time media whose value expires, such as audio and video frames.

Entries in a `reliable` flow are delivered in position order. Entries
in a `loss-tolerant` flow can be lost, and later entries do not
depend on earlier ones.

### Acceptance {#log-acceptance}

A receiver accepts an entry when it takes responsibility for it:
from then on it either processes the entry or reports an ERROR for
it. The accepted position of a flow, for one receiver, is the
highest position in that flow up to which the receiver has accepted
every entry it needs to.

* A receiver MUST record an entry as accepted before it, or the agent
  it serves, begins to act on the entry, and MUST keep that record
  for as long as it can resume the dialog. A receiver that fails after
  acting on an entry therefore never reports it as unaccepted.
* A receiver MUST discard an entry at or below its accepted position
  for that flow as a duplicate, without repeating its side effects.
* For a `loss-tolerant` flow, the accepted position is the highest
  position received; earlier lost entries are not recovered.

Acceptance is not completion. An accepted request can still be in
progress, fail, or be cancelled ({{cancellation}}); the application
protocol reports those outcomes.

### Log Status and Replay {#log-replay}

After a gap, reconnection, or failover, participants exchange their
accepted positions with LOG_STATUS so that each sender knows what to
make available again, and each receiver knows what to retrieve. This
answers whether a sender needs to replay its input
({{Section 6.1.2 of ARCH}}) without inferring it from transport state.

* A participant that resumes a dialog first resynchronizes the dialog
  context with STATE_REQUEST ({{propagation}}). It then sends
  LOG_STATUS without `in_reply_to`, listing in `positions` its
  accepted position for each flow it consumes.
* Each participant that receives such a LOG_STATUS and consumes flows
  of the sender answers with LOG_STATUS, with `in_reply_to` naming
  it, listing its accepted positions for the sender's flows only.
* For each `reliable` flow it sends, the resuming participant makes
  every entry above the lowest accepted position reported for that
  flow available to the receivers again, at the same positions and
  with the same content, as the binding defines. It MUST NOT
  re-send an entry with new content at an existing position, and
  MUST NOT send again as new entries the content of entries a
  receiver has already accepted.
* The resuming participant retrieves entries above its own accepted
  positions in other participants' flows, as the binding defines.
* Entries in `loss-tolerant` flows are not replayed.

A sender retains each entry of a `reliable` flow until every
participant consuming that flow reports an accepted position at or
above it, or for the `log_retention` time ({{dialog-parameters}}),
whichever comes first. A receiver whose accepted position falls below
what the sender still retains cannot recover the missing entries; it
SHOULD report this to the application and MAY request the current
state through the application protocol.

A new client instance of a participant ({{device-handover}}) uses the
same procedure to rehydrate the log: it retrieves the entries it
needs to show, in each flow, from the positions it chooses. A binding
MUST define how a participant retrieves entries by flow and position
range, or MUST state that it does not support rehydration.

LOG_STATUS does not change the dialog context and does not advance
the generation. A participant MUST NOT include log content in it.

# MOQT Binding {#moqt-binding}

This section specifies how the dialog management protocol of
{{dialog-management}} is carried over MOQT.

## Namespace Organization {#namespace}

PACE uses MOQT's hierarchical namespace for routing, isolation, and
multiplexing. In MOQT, content is addressed by a Track Namespace (an
ordered set of up to 32 fields, compared as byte sequences
{{MoQ-TRANSPORT}}) together with a Track Name. PACE organizes
communication into two namespace scopes: an agent namespace for each
agent's identity and invitations, and a dialog namespace for all of a
dialog's traffic.

### Agent Namespace

~~~
  ("pace", "agents", {agent-id}) -- {track}
~~~

This is an agent's persistent identity on the relay network. Each agent
publishes the following tracks:

* `"card"` — Agent Card containing capabilities, identity claims,
  authentication schemes, and MOQT connectivity information
  ({{agent-card}})
* `("pace", "agents", {agent-id}, "invites") -- {invitee-id}` — One
  track per agent it invites to dialogs ({{invitations}})

The common prefix `("pace", "agents")` enables SUBSCRIBE_NAMESPACE-based
discovery of all agents on the network. An agent follows another by
subscribing to its card and to the invitation track named by the
follower's own agent-id. See {{agent-discovery}} for the complete
discovery flow.

### Dialog Namespace {#dialog-namespace}

~~~
  ("pace", "dialogs", {dialog-id}, {agent-id}) -- {track}
~~~

The dialog-id is the dialog identifier ({{dialog-context}}). The
controller mints it when it opens the dialog. Each participant
publishes its tracks for the dialog under its own agent-id field
within the dialog's namespace; the agent-id is the participant
identifier used in the dialog context. Each participant issues
SUBSCRIBE_TRACKS on the dialog prefix `("pace", "dialogs",
{dialog-id})`, so it receives every participant's tracks, including
those of participants added later, as PUBLISH messages forwarded by
the relay.

Each participant in a dialog publishes the following tracks:

* `"ctrl"` — Dialog control messages ({{control-encoding}})
* `"chat"` — Chat messages and streaming LLM output
* `"audio"` — Real-time audio stream
* `"video"` — Real-time video stream
* `"progress"` — Progress output, such as token counts, elapsed time,
  and liveness signals ({{liveness}}), kept apart from the response
* `"ops/{req-id}"` — Request/response operations (one track per request)

Only the `ctrl` track carries the dialog context. The other tracks
carry dialog content and are outside the dialog context. In the terms
of {{Section 4.2.11 of ARCH}}, `chat`, `audio`, and `video` carry
response output, operation and protocol binding tracks carry
information output, and `progress` carries progress output. Extensions
define further tracks, such as the `checkpoint` track of PACE
Authorization ({{delegation-approval}}).

Protocol bindings extend the dialog namespace with additional
namespace fields, so that multiple protocols can operate concurrently
within a single dialog without track name collisions:

~~~
("pace", "dialogs", {dialog-id}, {agent-id}, {proto}, {category},
 ...) -- {id}
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
  ("pace","dialogs",D,"agent-a","a2a","request") -- "r1"

A2A: "agent-b" publishes updates for task "t1"
  ("pace","dialogs",D,"agent-b","a2a","task") -- "t1"

MCP: client "agent-a" calls tool "read_file" on "fs-server"
  ("pace","dialogs",D,"agent-a","mcp","tools","read_file")
      -- "request"

MCP: "fs-server" publishes the result of that call
  ("pace","dialogs",D,"fs-server","mcp","tools","read_file")
      -- "response"
~~~

The MCP tracks above are the `request` and `response` tracks of
`(mcp, {server-id}, clients, {client-id}, tools, {tool-name})` in MCP
over MOQT {{MCP-MOQT}}, with the leading
`(mcp, {server-id}, clients, {client-id})` fields replaced by the
dialog namespace and the publisher's agent-id ({{mcp-binding}}).

See {{example-workflows}} for concrete examples of agent-to-agent,
agent-to-tool, and multi-agent collaboration workflows.


### Invitations {#invitations}

~~~
  ("pace", "agents", {controller-id}, "invites") -- {invitee-id}
~~~

An agent learns a dialog's dialog-id before it can subscribe to the
dialog. A controller tells an invitee that follows it
({{agent-discovery}}) by publishing on a track under its own agent
namespace, named by the invitee's agent-id. Each object, in its own
group, is a JSON object with these members:

* `dialog_id` — The dialog identifier
* `controller_id` — The controller's agent-id
* `expires_at` — Optional; the time after which the invitation is
  void

An invitation only points to the dialog. The dialog context, including
the OPEN or UPDATE that invites the agent, stays on the controller's
`ctrl` track, which the invitee reads before deciding. Relay
authorization ({{relay-authorization}}) forwards each invitation track
only to the invitee it names, so other followers of the controller do
not see it. An invitee that comes online late catches up on pending
invitations with a join fetch and ignores those whose `expires_at` has
passed.

An agent that does not follow the controller learns the dialog-id out
of band, for example through the application protocol's own channel
({{poppy-binding}}).

Editor's note: This document does not define how to invite an agent
that neither follows the controller nor can be reached out of band, or
how to advertise a dialog for others to join. These are left for
future work.

## Transport Binding {#transport-binding}

### Connection Establishment {#connection-establishment}

Agents MUST establish either a native QUIC connection or a WebTransport
{{WEBTRANS-H3}} session as defined in {{MoQ-TRANSPORT}}. For native QUIC
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

Each agent publishes only under its own agent-id: its card and
invitations under `("pace","agents",{agent-id})`, and its dialog
tracks under `("pace","dialogs",{dialog-id},{agent-id})`. A
participant issues SUBSCRIBE_TRACKS on the dialog prefix to receive
the tracks of all participants. The relay handles fan-out to all
subscribers via prefix matching. This publishing model ensures clear
ownership and enables relay caching.

Namespace structure and track names are defined in {{namespace}}.

### Message Serialization {#message-serialization}

Each PACE object payload is one protocol message, with no PACE
header: a control message ({{control-encoding}}) on `ctrl` tracks, an
invitation on invitation tracks, and the protocol's native message on
binding tracks. The
track namespace identifies the protocol, and MOQT carries the length.

Payloads are uncompressed unless the participants agree on a
`content_encoding` dialog parameter ({{dialog-parameters}}). It
applies to binding tracks only, never to `ctrl` or invitation tracks.

### Log Mapping {#log-over-moqt}

The log of {{dialog-log}} maps onto MOQT without additional headers:

* A flow is a track the participant publishes in the dialog, other
  than `ctrl` and invitation tracks. In `positions`, `flow` takes the
  form used by CANCEL `target` ({{cancel-over-moqt}}): `namespace`,
  listing the namespace fields that follow
  `("pace","dialogs",{dialog-id},{agent-id})`, and `track`.
* A log entry is an object, and its position is the object's Location.
  `accepted` is encoded as `{"group": G, "object": O}`.
* The output class follows from the track name ({{dialog-namespace}}).
  The delivery class is `loss-tolerant` for tracks sent with Datagram
  Delivery Mode or a finite delivery timeout, and `reliable`
  otherwise.
* Timestamps are not carried; a protocol binding that needs them
  carries them in its native messages.
* A transformer publishes renderings under the namespace fields
  `("render", {source-id}, {source-track})` after its own agent-id,
  where `{source-track}` is a track the source publishes directly
  under its dialog namespace, such as `audio` or `chat`,
  with the rendering's label, such as a language tag, as the track
  name. The `{source-id}` field gives `source_id`, and an object in
  group G is derived from group G of the source track, which gives
  `derived_from` at the granularity of a group.

A publisher makes entries available again by continuing to serve
them with FETCH; a relay's cache can serve them as well, but the
publisher does not rely on it. A receiver retrieves entries above its
accepted position with FETCH from the next Location, or with a join
fetch when it resumes a subscription ({{dialog-recovery}}). A
publisher that restarted without its earlier objects cannot make them
available again; it starts each track at a new group, and receivers
treat the missing range as described in {{log-replay}}.

## Dialog Operations over MOQT {#dialog-over-moqt}

This section specifies how the operations of {{dialog-management}} are
carried over MOQT. Each control message is one MOQT object on the
sender's `ctrl` track under
`("pace","dialogs",{dialog-id},{agent-id})`. MOQT control messages
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

Prerequisite: B learns the dialog-id from A's invitation, which
requires that B follows A ({{agent-discovery}}), or out of band. A
does not need B's prefix: all participants' tracks are under the
dialog prefix.

Below, PUBLISH, SUBSCRIBE, and SUBSCRIBE_TRACKS are MOQT messages;
OPEN, ACCEPT, and UPDATE are PACE control messages sent as objects on
the sender's `ctrl` track. Agent A (controller) opens a dialog with
Agent B (invitee):

1. A generates a dialog-id (UUID version 4) and issues
   SUBSCRIBE_TRACKS on `("pace","dialogs",{dialog-id})`, which covers
   all participants' tracks, including future ones.

2. A issues PUBLISH for
   `("pace","dialogs",{dialog-id},"agent-a") -- "ctrl"` and sends OPEN
   on it, listing B as `invited`, with `parameters`
   ({{dialog-parameters}}) and `credentials`.

3. A sends an invitation on
   `("pace","agents","agent-a","invites") -- "agent-b"`
   ({{invitations}}), which B subscribed to when it started following
   A.

4. B issues SUBSCRIBE with FILL_PARAMETERS on A's `ctrl` track, reads
   OPEN, and decides. Until it accepts, B subscribes to nothing else,
   so it receives no dialog content.

5. B issues PUBLISH for
   `("pace","dialogs",{dialog-id},"agent-b") -- "ctrl"` and sends
   ACCEPT (or REJECT) on it, with its parameters and credentials. On
   accepting, B issues SUBSCRIBE_TRACKS on the dialog prefix, which
   also covers A's `ctrl` track.

6. The relay forwards B's PUBLISH to A through A's SUBSCRIBE_TRACKS
   from step 1, and A reads ACCEPT.

7. A sends UPDATE (generation 1) on its `ctrl` track, marking B and
   the dialog `active`. If B rejected, the UPDATE marks B `rejected`,
   and B ends its `ctrl` track with PUBLISH_DONE.

Tracks either agent publishes later reach every participant through
its SUBSCRIBE_TRACKS on the dialog prefix. Multi-party dialogs follow
the same pattern, and existing participants receive a new
participant's tracks without subscribing again.

### Joining a Dialog {#joining}

An agent that knows a dialog's dialog-id but was not invited asks to
join by issuing PUBLISH for its own `ctrl` track,
`("pace","dialogs",{dialog-id},{joiner-id}) -- "ctrl"`, and sending
JOIN_REQUEST as the first object on it. The relay forwards the
PUBLISH to every participant holding SUBSCRIBE_TRACKS on the dialog
prefix, not only the controller. Only the controller acts on
JOIN_REQUEST; other participants MUST ignore it, and MAY decline a
PUBLISH for a track whose agent-id is not in the dialog context. A
joiner therefore discloses in its credentials only claims it is
willing for every participant to see. The controller validates the
credentials and decides whether to admit the joiner. The joiner
subscribes to the controller's `ctrl` track with FILL_PARAMETERS, so
it receives the current dialog state as well as the answer. To
admit it, the controller invites the joiner with UPDATE, the joiner
answers with ACCEPT and subscribes to the dialog prefix, and the
controller's next UPDATE marks it `active`. A controller that declines
answers with ERROR `policy-rejected`, and the joiner then ends its
`ctrl` track with PUBLISH_DONE. Before admission, the joiner's
authorization covers only publishing its own `ctrl` track and reading
the controller's ({{relay-authorization}}). A joiner with a `sponsor`
or a `join_code` follows the same steps; the controller admits it as
{{sponsored-admission}} and {{joining-codes}} require.

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
participant answers with ACCEPT or REJECT ({{lifecycle}}). An UPDATE
that adds a participant is followed by an invitation to it
({{invitations}}).

A participant sends DECLARE on its own `ctrl` track; because every
participant subscribes to the dialog prefix, each sees the DECLARE as
well as the controller's committing UPDATE, and can compare them
({{participant-descriptors}}). The controller sends SEGMENT on its
`ctrl` track, opens the segment dialog with a dialog-id of its own,
and invites only the segment's participants to it; relays authorize
that dialog's namespace for them alone ({{relay-authorization}}).

Participants MAY use MOQT's REQUEST_UPDATE message
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
  on its agent namespace, its follow subscriptions
  ({{agent-discovery}}), and SUBSCRIBE_TRACKS on the dialog prefix,
  which includes the controller's `ctrl` track, and sends STATE_REQUEST with its last
  accepted generation. It applies the controller's STATE only after
  authenticating the controller and checking that the generation is not
  older than its last accepted one ({{generations}}). It then sends
  LOG_STATUS ({{log-replay}}) and fetches, on each content track, the
  objects after the accepted position it holds.
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
  create a replacement dialog. If the context names an
  `alternate_controller_id`, the alternate can take over
  ({{controller-transfer}}); its `ctrl` track already reaches every
  participant through their subscription to the dialog prefix. A slow
  subscriber whose subscription ends with PUBLISH_DONE
  (TOO_FAR_BEHIND) resubscribes and resynchronizes with STATE_REQUEST.
* Mediator Failover: A relay is never authoritative, so an agent whose
  relay fails reconnects through another relay without changing the
  dialog. An application-level mediator that is a participant is
  replaced by the controller with REVOKE and UPDATE; one that is the
  controller is replaced by controller transfer.

#### Moving to Another Device {#device-handover}

A participant, such as a user's client, can continue a dialog on
another device under the same agent-id. Two instances MUST NOT publish
the same track at the same time.

1. The new instance obtains the participant's credentials and key,
   connects to a relay, and subscribes to the dialog prefix.
2. The old instance, if reachable, ends its dialog tracks with
   PUBLISH_DONE and its subscription to the dialog prefix.
3. If the participant is not the controller, the new instance resumes
   with STATE_REQUEST and a key-bound presentation ({{key-binding}}).
   If it is the controller, the new instance first recovers its own
   last control objects with FETCH on its `ctrl` track, and publishes
   no state-changing operation until it holds the latest generation.
4. The new instance publishes its tracks, starting each content track
   at a new group, and uses join fetch on content tracks to restore
   the history it shows to the user.

If the old instance is unreachable and later returns, it sees the new
instance's objects on its own tracks, stops publishing, and
resynchronizes.

### Cancellation {#cancel-over-moqt}

A participant sends CANCEL ({{cancellation}}) as an object on its
`ctrl` track at critical priority (0-15). Scopes `dialog` and
`subtree` need no `target`. For scope `subtree`, a receiver that
controls a delegated dialog whose `parent_dialog_ids` include this
dialog sends CANCEL with scope `dialog` on its own `ctrl` track in
that delegated dialog. For scope `operation`, `target` names a track
the sender publishes in the dialog and, optionally, a group on it:

~~~json
{
  "namespace": ["mcp", "tools", "search"],
  "track": "request",
  "group": 3
}
~~~

`namespace` lists the namespace fields that follow
`("pace","dialogs",{dialog-id},{agent-id})`. Without `group`, all work
started by objects on the track is cancelled. An ERROR that rejects an
application operation ({{error-reasons}}) uses the same form, with an
additional `publisher` member giving the agent-id that published the
operation, since the rejecting participant is not its publisher. Each receiver doing the
affected work publishes CANCEL_ACK on its own `ctrl` track and stops
publishing objects for that work, ending a track that carried only
that work with PUBLISH_DONE.

Pausing delivery with REQUEST_UPDATE (FORWARD=0), unsubscribing, or
closing a MOQT session does not cancel work.

### Termination and Revocation

The controller ends the dialog by sending TERMINATE on its `ctrl`
track ({{termination}}). Upon termination, pending operations are
cancelled, each participant terminates the delegated dialogs it
controls ({{lifecycle-propagation}}), and dialog resources are
released after a configurable grace period.

After TERMINATE, or when `expires_at` passes, each participant SHOULD
send PUBLISH_DONE on every dialog track it was publishing (ctrl,
chat, audio, video, and any operation tracks), and ends its
subscription to the dialog prefix. PUBLISH_DONE signals that no
further objects will be delivered on the track, allowing subscribers
and relays to release state without waiting for timeouts. Neither
PUBLISH_DONE nor STOP_SENDING substitutes for TERMINATE.

A participant leaves by sending LEAVE on its `ctrl` track. The
controller commits it with UPDATE, marking the participant `left`,
and SHOULD send TERMINATE if only the controller remains active
({{lifecycle}}). The leaver then ends its tracks with PUBLISH_DONE and
its subscription to the dialog prefix.

When the controller sends REVOKE, every participant stops forwarding
dialog context to the revoked participant and cancels any
subscriptions held only on its behalf ({{lifecycle}}). The revoked
participant ends its tracks with PUBLISH_DONE, and participants MAY
decline its later PUBLISHes. The deployment
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

Each modality maps to dedicated MOQT tracks within the dialog
namespace ({{dialog-namespace}}). Different modalities are
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
| 16-31 | Urgent Signals | Signals that must preempt content, such as authorization checkpoints ({{delegation-approval}}) or a request for a human |
| 32-63 | Real-time Media | Voice/video frames |
| 64-95 | Interactive | Chat messages, streaming LLM tokens |
| 96-127 | Standard Operations | Tool calls, request/response |
| 128-159 | Discovery | Agent Cards, invitations |
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
`("pace","dialogs",{dialog-id},"agent-a") -- "ops/{req-id}"`. Agent B,
which has subscribed to the dialog prefix, receives the request,
processes it, and publishes the response on its own corresponding track
`("pace","dialogs",{dialog-id},"agent-b") -- "ops/{req-id}"`. Agent A
receives the response through its own subscription to the dialog
prefix.

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
  subscribe to the dialog prefix. The controller adds a participant
  with UPDATE; existing participants see the new participant in the
  context and receive its tracks through their existing subscription.
* Hierarchical Teams: A coordinator creates child PACE dialogs to
  delegate subtasks. Each level operates as a separate dialog with
  narrowed authorization scope, and each child's `parent_dialog_ids`
  links it to the dialogs above it ({{dialog-context}}). Delegation
  chains ({{delegation}}) maintain an auditable path from the
  original user authorization, and CANCEL with scope `subtree` stops the
  work below a level ({{cancellation}}).

A dialog has one visibility scope: every participant subscribes to the
dialog prefix and can receive every other participant's tracks. When
participants must not see each other's traffic, such as tools from
different administrative domains used by one agent, or a subset of
agents that needs a private exchange, the agent SHOULD open a separate
delegated dialog for each, linked by `parent_dialog_ids`, rather than
adding them to one dialog. When the other participants need to know
that such an exchange happened and its result, as for a masked payment
or an off-the-record span, the controller announces it as a segment
({{segments}}).

# Agent Identity and Discovery {#identity-discovery}

## Agent Identity Model

PACE treats the agent as an authenticated party distinct from the
principal it represents. Separating the two makes it possible to revoke an
agent without affecting the user, scope an agent to a subset of what
the user is allowed to do, and audit what the agent did on its own
versus what the user initiated.

PACE does not define a new identity token format or claim set. The
credential an agent presents in the `credentials` member of the
control message it uses to open, accept, or join a dialog
({{control-encoding}}) identifies:

* the agent, by its participant identifier in the dialog or by an
  identifier that the protocol binding relates to it, such as the
  Poppy `client_id` ({{poppy-binding}});
* the user, workload, or organization the agent acts for; and
* when the agent acts for another agent, the delegation chain
  ({{delegation}}).

In JWT-based formats, these map to the registered claims `sub`, `iss`,
`iat`, and `exp` {{RFC7519}} and to the `act` (actor) claim
{{RFC8693}} for delegation. `sub` identifies the principal: the user,
workload, or organization on whose behalf the work is done, not the
agent presenting the credential. The acting agent is identified by
`client_id` or by the outermost `act`, and the meaning and validation
of `act` chains follow the OAuth Actor Profile {{ACTOR-PROFILE}}. Other
formats carry the equivalent information in their own fields. How a
person's sign-in with OpenID Connect, cross-domain grants, and
out-of-band approval relate to these credentials is profiled in
{{PACE-OIDC}}; an ID Token is not a PACE credential. The token format and the trust
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
| OAuth 2.1 access token (JWT or opaque) | Token claims | Delegated user authorization | {{OAUTH-2.1}} |
| GNAP | | Fine-grained, continuous grants | {{RFC9635}} |
| WIMSE workload credentials | Workload identity | With deployment policy | {{WIMSE-CREDS}} |
| WIMSE Workload Proof Token with message binding | Proof of possession bound to the control message | Binds the tokens presented with it | {{WIMSE-WPT}}, {{WPT-MSG}} |
| mTLS client certificate | Infrastructure-anchored identity | With deployment policy | {{RFC8446}} |
| OAuth Client ID Metadata Document | Agent keys published at its own HTTPS `client_id` URL | With deployment policy | {{CIMD}} |
| Common Access Token (CAT) | | Relay-level namespace authorization | {{MoQ-C4M}} |

WIMSE workload credentials and mTLS need trust anchors configured in
advance. Agents with no prior relationship, such as a person's agent
contacting a business for the first time, can instead identify
themselves by an HTTPS URL at which they publish a client metadata
document with their keys {{CIMD}}; a verifier fetches it and checks a
key-bound presentation ({{key-binding}}) against those keys. This
shows that the agent controls the URL's domain, not who operates it
or whom it acts for.

A deployment profile MUST pick at least one mechanism for identity and
one for authorization; one mechanism can provide both. Receivers MUST
verify a credential's signature, issuer, and expiration before acting
on its claims, and validate authorization using the rules of the
mechanism in use.

### Delegation Chains {#delegation}

When an agent acts on behalf of another agent, its credential carries
the delegation chain, such as nested `act` claims {{RFC8693}}, tracing
the authorization path (for example, User → Coordinator → Researcher
→ Tool). Where an authorization server issues each hop's token, the
chain is that server's assertion, with the semantics of
{{ACTOR-PROFILE}}. Where agents in different trust domains delegate
to each other without an authorization server, the chain is a
sequence of Delegation Tokens {{DELEGATION-TOKENS}} in which each hop
is signed by its delegator {{AGENT-DELEGATION}}. PACE carries the credential in OPEN and identifies the
delegated dialog's parents in `parent_dialog_ids`; it does not define
delegation semantics. How a delegation credential is bound to the
delegated dialog, how authority narrows at each hop, which credential
formats suit which deployments, how cycles are rejected (with ERROR
`delegation-cycle`), and how revocation of a delegation terminates the
dialogs that depend on it are specified in PACE Authorization
({{delegation-approval}}).

### Selective Disclosure {#selective-disclosure}

Different peers need different claims: a tool may need only the
agent identifier and its authorization, not the delegation chain or
the principal. Agents SHOULD disclose only what each peer requires,
using the selective disclosure of the mechanism in use
({{identity-formats}}). For agent metadata, SD-Card {{SD-CARD}} lets
an agent disclose issuer-attested claims per peer, and an Agent Card
({{agent-card}}) can be an SD-Card.

Selective disclosure does not make agents anonymous: an SD-Card's
`sub` is always disclosed and stable, so its presentations can be
linked ({{Section 3.1 of SD-CARD}}). Identifier linkage is addressed
in {{privacy}}.

### Key-Bound Presentation {#key-binding}

A presentation proves possession only when it is bound to the
verifier and to a fresh value from it, such as an SD-Card Key Binding
JWT ({{Section 6 of SD-CARD}}). A verifier sends a `nonce` in its
control message ({{control-encoding}}), and the peer's next control
message carries, in its `credentials` member, a presentation bound to
that nonce, with the verifier's agent-id as audience.

A presentation also binds the control message that carries it, so
that a copy of it in another message does not verify. It does so with
the `mth` claim of {{WPT-MSG}}, computed under the `pace`
canonicalization profile below. Each presentation carries `nonce`
(the verifier's nonce), `aud` (the verifier's agent-id), and `mth`.
PACE supports three presentation types, one for each kind of
credential, and a verifier tells them apart by the JOSE `typ` header:

| Presentation type | `typ` | Used with |
|---|---|---|
| Workload Proof Token {{WIMSE-WPT}} | `wpt+jwt` | WIMSE workload credentials |
| Key Binding JWT {{RFC9901}} | `kb+jwt` | SD-JWT and SD-Card credentials |
| PACE presentation JWT ({{presentation-jwt}}) | `pace-presentation+jwt` | Other credentials bound to a key |
{: #table-presentations title="Presentation Types"}

A Workload Proof Token is carried in the message as {{WPT-MSG}}
describes; a Key Binding JWT carries `mth` as an additional claim. The
PACE presentation JWT covers credentials whose key a `cnf` claim
{{RFC7800}} confirms, such as a DPoP-bound access token or a JWT; keys
published in a Client ID Metadata Document {{CIMD}}; and the key of an
mTLS client certificate, which cannot be proven to a peer over TLS
because relays terminate it.

A participant that verifies key-bound presentations MUST support the
PACE presentation JWT, which works with any credential bound to a key.
It supports the other types as the credential mechanisms of its
deployment require ({{identity-formats}}).

A credential bound to no key, such as a bearer token, cannot be bound
to a presentation. A verifier relies on it only as far as its
credential mechanism and the deployment's policy allow.

The `pace` profile applies the `json-jcs` profile of {{WPT-MSG}} to a
PACE control message, with `credentials` as the credential member: the
`mth` hash is computed over the JCS {{RFC8785}} form of the control
message with its `credentials` member removed. A presentation can
therefore travel inside the message it binds, and a copy of it in
another message does not verify.

#### PACE Presentation JWT {#presentation-jwt}

Some credentials are bound to a key but have no proof that a PACE peer
can check. A DPoP proof {{RFC9449}} covers an HTTP request, not a
control message. An mTLS client certificate is proven in the TLS
handshake, which ends at the first relay. A JWT with a `cnf` claim, or
a key published in a Client ID Metadata Document, has no presentation
of its own. Without a proof, a peer cannot tell the credential's
holder from anyone who copied it.

A participant that presents such a credential therefore sends a PACE
presentation JWT with it, in the same `credentials` member, in each
control message that carries the credential. A participant whose
credential has its own presentation, a Workload Proof Token or a Key
Binding JWT, uses that instead.

A PACE presentation JWT is a JWT {{RFC7519}}, signed with JWS
{{RFC7515}} by the private key that the credential it accompanies
confirms. Its `alg` MUST be an asymmetric digital signature algorithm,
and MUST NOT be `none` or a MAC algorithm. Its JOSE header carries:

* `typ`: REQUIRED. `pace-presentation+jwt`.
* `jwk` or `x5c`: The public key as a JWK when the credential
  confirms only a key thumbprint, or the certificate chain for an
  mTLS client certificate. Omitted when the credential carries the key
  itself.

Its claims are:

* `aud`: REQUIRED. The verifier's agent-id.
* `nonce`: REQUIRED. The verifier's `nonce`.
* `iat` and `jti`: REQUIRED.
* `ath`: REQUIRED. The base64url-encoded SHA-256 hash {{RFC6234}} of
  the ASCII encoding of the credential it accompanies.
* `mth`: REQUIRED. The message hash of {{WPT-MSG}}, under the `pace`
  profile.

The verifier checks the signature with the key that the credential
confirms, after checking a `jwk` or `x5c` against the credential's
thumbprint or certificate; and checks `typ`, `aud`, `nonce`, `ath`,
and `mth`. It rejects a presentation whose `jti` it has already
accepted in the dialog.

When a dialog opens ({{opening}}), OPEN carries the controller's
nonce, ACCEPT carries the invitee's bound presentation and its own
nonce, and the controller's UPDATE carries its presentation bound to
that nonce. Joining uses JOIN_REQUEST, UPDATE, and ACCEPT the same
way ({{joining}}). A participant that requires a key-bound
presentation and does not receive a valid one MUST NOT treat the peer
as authenticated.

Resumption uses STATE_REQUEST and STATE the same way. A participant
resuming a dialog sends STATE_REQUEST with a `nonce` and a
presentation in `credentials`; if it holds a nonce from the
controller's last message, the presentation is bound to it. The
controller's STATE carries a presentation bound to the STATE_REQUEST
nonce. The controller thereby verifies that the resuming party is the
participant whose exchange was interrupted, and the participant
verifies the controller. The controller answers with ERROR instead of
STATE when the dialog is terminated (`dialog-terminated`), the
participant is revoked (`participant-revoked`), or the check fails
(`unauthenticated`, `unauthorized`) or cannot be completed
(`authorization-unavailable`). A controller that resumes sends its own
nonce in its next control message and requires each participant's
next control message to carry a presentation bound to it.

### Records and Provenance {#records}

Relays forward control messages unchanged, but transport security
authenticates only the adjacent hop, and PACE defines no audit data
structures. A deployment that requires control messages and content to
be attributable end to end, with records that parties other than the
operator can check, adds an evidence mechanism of its choice; PACE
does not mandate one and its messages are unchanged by it. What such a
mechanism records for delegations and approvals is described in
PACE Authorization ({{delegation-approval}}); TRAIL {{TRAIL}} is one example of such a mechanism.

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

Once Agent B knows Agent A's agent-id, B follows A with two
subscriptions:

1. B issues SUBSCRIBE on `("pace","agents","agent-a") -- "card"` and
   reads A's Agent Card ({{agent-card}}).
2. B issues SUBSCRIBE on
   `("pace","agents","agent-a","invites") -- "agent-b"`. When A
   invites B to a dialog, the invitation arrives on this track
   ({{invitations}}), and B then subscribes to the dialog.

Following is B's choice: B follows the agents from which it is willing
to receive invitations. Following does not show B any of A's dialogs.
A follows B the same way when it expects invitations from B.

### Agent Card {#agent-card}

Each agent publishes an Agent Card on track `"card"` under its namespace
`("pace","agents",{agent-id})`. When capabilities change, the agent
publishes a new object (incrementing the MOQT group).

All Agent Cards MUST include:

* Agent identifier (UUID) and display name
* Supported modalities and protocols
* Authentication schemes
* Identity claims (issuer, public key, expiration)

PACE does not define a card format. An Agent Card is the agent's
application protocol metadata in a signed form, such as an A2A Agent
Card ({{a2a-binding}}) or an SD-Card {{SD-CARD}}, which lets the agent
disclose different claims to different peers. The card names the
agent's namespace `("pace","agents",{agent-id})`, and receivers MUST
check that it equals the namespace on which the card was published.

The `"card"` track reaches every subscriber through relays, so a card
on it is not bound to any one verifier. It shows that its claims are
signed and unmodified, but not that the publisher is the agent.
Receivers MUST verify the card's signature and expiration before
acting on its claims, and a participant that relies on the agent's
identity MUST obtain a key-bound presentation in `credentials`
({{key-binding}}).

Every subscriber sees the card, so an agent that uses pairwise or
per-dialog agent-ids ({{privacy}}) publishes a separate card, with a
separate key, for each agent-id; otherwise the card links them.

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
PACE dialog, using the dialog namespace ({{dialog-namespace}})
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
| MCP | `_meta` | JSON-RPC request IDs and the {{MCP-MOQT}} client ID |
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
* Identity and authorization: how the protocol's own identity and
  authorization constructs (if any) relate to the credential
  mechanisms ({{identity-formats}}) in this document.

A complete mapping of each protocol operation to MOQT primitives
belongs in a protocol-specific document, such as {{MCP-MOQT}} for MCP.

Protocols use distinct protocol namespace fields within PACE dialogs.
In the tables of this section, a pattern such as
`("a2a", "task") -- {task-id}` gives the namespace fields that follow
`("pace", "dialogs", {dialog-id}, {agent-id})`, then the track name.

In the examples, D is the dialog-id.

| Binding | Protocol Fields | Example Full Track Name |
|----------|--------------|-------------------|
| MCP | `"mcp"` | `("pace","dialogs",D,"fs","mcp","tools","read") -- "response"` |
| Poppy | `"poppy"` | `("pace","dialogs",D,"acme","poppy","conversation") -- "events"` |
| A2A | `"a2a"` | `("pace","dialogs",D,"agent-a","a2a","task") -- "t1"` |
| Generic | `"ext", {proto}` | `("pace","dialogs",D,"agent-a","ext","proto","rpc") -- "call"` |

## MCP Binding {#mcp-binding}

The Model Context Protocol {{MCP}} binding enables tool and resource
access for agents. Within a PACE dialog, MCP tracks add an `"mcp"`
namespace field after the dialog-id, under the namespace of the agent
that publishes the track:

~~~
Namespace: ("pace", "dialogs", {dialog-id}, {agent-id}, "mcp",
            {category}, ...)
Tracks:    {track-name}
~~~

The complete MCP over MOQT specification, covering track structure,
operation mapping, message serialization, Agent Skills, and relay
support, is defined in {{MCP-MOQT}}. PACE adopts its track semantics.
The mapping is mechanical: the leading
`(mcp, {server-id}, clients, {client-id})` or `(mcp, {server-id})`
fields of an MCP over MOQT namespace are replaced by `("pace",
"dialogs", {dialog-id}, {agent-id}, "mcp")`, and the remaining
namespace fields and the track name are kept unchanged. For example,
with `{cli}` and `{srv}` the agent-ids of the MCP client and server:

| Track | MCP over MOQT | Within PACE |
|-------|---------------|-------------|
| Tool request | `(mcp, {server-id}, clients, {client-id}, tools, {tool-name}) -- request` | `("pace","dialogs",{dialog-id},{cli},"mcp","tools",{tool-name}) -- "request"` |
| Tool response | `(mcp, {server-id}, clients, {client-id}, tools, {tool-name}) -- response` | `("pace","dialogs",{dialog-id},{srv},"mcp","tools",{tool-name}) -- "response"` |
| Resource | `(mcp, {server-id}, resources) -- {resource-uri}` | `("pace","dialogs",{dialog-id},{srv},"mcp","resources") -- {resource-uri}` |
{: title="MCP over MOQT Tracks within PACE"}

MCP needs no handshake of its own, and MCP over MOQT client IDs are
not used within PACE: PACE supplies the dialog-id, and peers learn
each other's MCP tracks through SUBSCRIBE_TRACKS on the dialog
prefix.

MCP messages keep their native JSON-RPC format as the object payload
({{message-serialization}}) and carry the dialog reference in `_meta`
({{carrying-dialog-context}}). Key operations map as follows:

| MCP Operation | MOQT |
|---------------|------|
| `tools/call` | Request object in a new group on the client's `("mcp","tools",{tool-name}) -- "request"` track; the result in the same group on the server's matching `"response"` track |
| Progress and partial results | Further objects in that group on the `"response"` track ({{streaming}}) |
| `resources/read` | FETCH or SUBSCRIBE on the server's `("mcp","resources") -- {resource-uri}` track |
| `notifications/cancelled` | Applied from PACE CANCEL ({{cancellation}}) |

MCP tracks use the PACE priority tiers ({{data-exchange}}) as
{{MCP-MOQT}} assigns them: control, tool, prompt, task and skill
execution tracks use Standard Operations, catalog and skill content tracks
Discovery, and resource tracks Bulk Transfer.

An MCP server that holds an MCP SD-Card returns a key-bound
presentation to the client that requests one
({{Section 8.2.4 of SD-CARD}}). That presentation is specific to the
requesting client, and SD-Card requires the response carrying it to
have a private `cacheScope`. Within PACE, relay authorization keeps
the response track within the dialog ({{relay-authorization}}). The
nonce and audience prevent replay of the presentation, but other
participants of the dialog can read the claims it discloses, so the
server discloses only claims that every participant may see.

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
        "endpoint": "https://acme.example/poppy/pace",
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
match and issuer checks) before using the entry. `namespace` is the
Company Agent's agent namespace, and `endpoint` is the HTTPS URL at
which the Personal Agent starts a conversation (see below).

A Company that holds a Company SD-Card ({{Section 8.3 of SD-CARD}})
carries the `agent` member of its `poppy.json` in the SD-Card's
selectively disclosable `agent` claim. It can therefore leave the
`pace` entry out of its public `poppy.json` and disclose it only to
the Personal Agents it chooses. A disclosed `pace` entry that also
appears in `poppy.json` MUST match it, as SD-Card's consistency rules
require.

### Namespace Structure

~~~
Namespace: ("pace", "dialogs", {dialog-id}, {agent-id}, "poppy",
            "conversation")
Tracks:    "messages" | "requests" | "events" | "deltas"
~~~

| Publisher | Track | Content |
|-----------|-------|---------|
| Personal Agent | `messages` | Poppy messages sent by the Personal Agent |
| Personal Agent | `requests` | Conversation requests: handoff to a human |
| Company Agent | `events` | Poppy events: `message`, `state`, `authorization`, `user_requested`, `direct_opened`, `direct_closed` |
| Company Agent | `deltas` | Non-durable `text-delta` events |

The Company Agent's `{agent-id}` is the one in the namespace advertised
in `poppy.json`. The Personal Agent's `{agent-id}` MUST be pairwise: it
MUST differ for each Company, MUST NOT be derived from the person's
identity, and SHOULD NOT equal the Poppy User ID. A Personal Agent MAY
use a fresh `{agent-id}` for each dialog. This preserves Poppy's
property that a Company knows a person only by an opaque identifier
that differs at every Company. It also stops relays, which always see
namespaces, from linking a person's conversations across Companies.
Personal Agents do not publish an Agent Card or answer agent discovery
({{agent-discovery}}), and the Company does not follow them.

### Starting a Conversation

The Company does not follow the Personal Agent, so the Personal Agent
gives it the dialog-id over HTTPS ({{invitations}}):

1. The Personal Agent generates a dialog-id and sends a POST request
   to `endpoint` with the Poppy-Session header, as for every endpoint
   a Poppy extension defines, and the body `{"dialog_id": "<D>",
   "agent_id": "<pairwise agent-id>"}`.
2. The Company verifies the Session JWT, issues SUBSCRIBE_TRACKS on
   `("pace","dialogs",D)`, and responds with a token {{MoQ-C4M}}
   that authorizes the Personal Agent for that dialog only
   ({{relay-authorization}}).
3. The Personal Agent connects to `relayEndpoint`, subscribes to the
   dialog prefix, and publishes OPEN on its `ctrl` track, with itself
   as controller and the Company Agent invited ({{opening}}). The
   dialog continues as in {{opening}} from step 5.

### Operation Mapping

Poppy messages and events keep their native JSON format as the object
payload ({{message-serialization}}). The dialog reference is not
carried in them, because the dialog-id is in every track namespace.

| Poppy Conversations | PACE / MOQT |
|---------------------|-------------|
| Start a conversation | The dialog-id handoff over HTTPS, then OPEN with the Personal Agent as controller (see above). The Poppy conversation ID is assigned as in Poppy and is distinct from the dialog-id |
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
  The relay enforces this ({{relay-authorization}}): the only
  participant token the Company issues for `("pace","dialogs",D)` is
  the owner's.
* Signing in: When the Company Agent needs account access, it publishes
  an `authorization` event; the Personal Agent signs in over HTTPS and
  continues the same dialog with new credentials. Because tokens pass
  through relays, the Personal Agent SHOULD use DPoP-bound tokens where
  the Company supports them: with DPoP proofs {{RFC9449}} for its HTTPS
  requests, and with DPoP proofs for MOQT {{MoQ-C4M}} for its
  SUBSCRIBE and PUBLISH actions on the dialog's tracks
  ({{relay-authorization}}). A token carried in the `credentials`
  member of a control message is accompanied by a proof bound to that
  message ({{key-binding}}).

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
Namespace: ("pace", "dialogs", {dialog-id}, {agent-id}, "ext",
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

Authorization proofs travel in the `credentials` member of control
messages: OPEN, ACCEPT, and JOIN_REQUEST, and UPDATE when the
controller presents its own ({{key-binding}}). Proofs are refreshed
before they expire by sending new credentials on a later control
message; long-lived dialogs SHOULD renew the proof in place rather
than terminating the dialog. Revoking an agent's authorization ends
its propagation relationship through REVOKE ({{lifecycle}}), and the
revoked agent terminates the dialogs it delegated under it
({{lifecycle-propagation}}).

### Delegation and Action Approval {#delegation-approval}

PACE Authorization {{PACE-AUTHZ}} specifies the authority agents
exercise in PACE dialogs: delegation credentials bound to the
delegated dialog, narrowing of authority at each hop, authorization
checkpoints through which an agent asks for approval of one action,
approval tokens that cover only that action, and optional evidence of
approvals. It reuses existing OAuth, WIMSE, and agent-protocol work
and states how each fits. A PACE deployment that delegates across
agents, or that requires approval of individual actions, uses it.

## Transport Security

All PACE traffic is encrypted under TLS 1.3 because QUIC requires it.
MOQT relays terminate QUIC and TLS on each hop, so transport-layer
authentication identifies only the adjacent hop. PACE therefore
authenticates participants at the application layer, through the
`credentials` member of control messages, as {{Section 7.2 of ARCH}}
requires when intermediaries terminate TLS.
Identity assertions and authorization proofs are signed and
short-lived. MOQT Common Access Tokens {{MoQ-C4M}} handle
namespace-level authorization at the relay.

### End-to-End Protection {#e2e-protection}

TLS protects each hop, but relays terminate it. To keep content
confidential and integrity-protected from relays, participants protect
object payloads with End-to-End Secure Objects {{MOQ-SECURE-OBJECTS}}.
A deployment that does not trust its relays with content MUST protect
every content track this way, and SHOULD protect `ctrl` objects,
and those of extension tracks such as `checkpoint` ({{delegation-approval}}),
too; relays do not need to read any PACE payload
({{relay-authorization}}).

Keys are scoped to a dialog. How they are established and distributed
to participants is chosen by the deployment; {{PACE-MLS}} specifies
one way, with an MLS group per dialog whose commits the controller
carries in its control messages. Where a key establishment mechanism
requires `ctrl` objects to be readable by participants before they
join, as {{PACE-MLS}} does, `ctrl` objects are left unencrypted and
remain authenticated by the presentations bound to each message
({{key-binding}}). When the controller commits a participant's
departure or revocation, the keys MUST be rotated so that the
departed participant cannot read later content, and when a
participant is added, they SHOULD be rotated so that it cannot read
earlier content it was not given.

### Relay Authorization {#relay-authorization}

Relays do not interpret PACE. They enforce, per namespace and track,
who may publish and who may subscribe, using the agent's token, for
example a Common Access Token {{MoQ-C4M}}. Because relays see these
tokens, they SHOULD be bound to the agent's key and presented with a
DPoP proof for each MOQT action, as {{MoQ-C4M}} defines for MOQT; the
proof names the action, Track Namespace, and Track Name in place of
the HTTP method and URI. A DPoP proof authorizes the MOQT action at
the relay. It does not cover the content of the objects published, so
credentials inside control messages are bound to the message with
`mth` ({{key-binding}}). The access each agent
needs follows from following ({{agent-discovery}}), invitations
({{invitations}}), opening ({{opening}}), and joining ({{joining}}),
and each agent publishes only under its own agent-id
({{track-organization}}). Where a participant's `access`
({{participant-descriptors}}) limits what it may send or receive, its
token covers only those tracks, so the relay enforces the limit; a
participant not in a segment holds no token for the segment dialog
({{segments}}). The controller, or its authorization server,
grants an agent access to a dialog on invitation or admission and
withdraws it when the agent leaves or is revoked.

Because each PACE subscription covers one track or one dialog prefix,
the relay checks it once, when it is made. Relays MUST refuse
subscriptions to a prefix of `("pace","dialogs")` shorter than a
dialog-id unless explicitly authorized, since they would reveal every
dialog on the relay. How tokens reach agents is deployment-specific;
the Poppy binding returns them over HTTPS ({{poppy-binding}}).

### Anonymous Relay Authorization {#anonymous-relay-authorization}

An access token tells every relay which agent is subscribing or
publishing, and its bytes link the agent's requests across dialogs.
Where relays need to know only that a request comes from a member of a
dialog, deployments MAY authorize with Privacy Pass tokens {{RFC9576}}
carried in MOQT as {{MOQ-PP}} defines, instead of or in addition to
access tokens:

* The controller's domain issues membership tokens to the
  participants it has admitted, under public metadata derived from the
  dialog-id, and stops issuing when a participant leaves or is revoked
  {{PP-AGENTS}}.
* Each token's scope, in its `origin_info`, covers the dialog's
  namespace and the actions the participant needs ({{MOQ-PP}}).
* Tokens SHOULD be holder-bound, with a redemption proof that names the
  MOQT request ({{PP-AGENTS}}), so that a relay or another party that
  sees a token cannot present it with another request. Unbound Privacy
  Pass tokens are bearer tokens, and relays see them.
* Subscriptions are kept authorized with fresh tokens before they
  expire ({{MOQ-PP}}). A participant whose tokens stop being issued
  loses access within the lifetime of the tokens it holds.

The relay then learns that a member of the dialog made the request,
not which member. Participants still identify one another through
`credentials` in control messages; these tokens hide participants only
from the relays. {{PACE-HTTP}} applies the same tokens to dialog hosts.

## Privacy Considerations {#privacy}

PACE dialog and participant identifiers (dialog-ids and agent-ids)
can persist across
intermediaries and trust boundaries. If several parties see them in
the clear, they can be used to correlate interactions that would
otherwise look unrelated. This is a known risk for any dialog
management protocol. Deployments mitigate it as follows:

* Identity claims and agent metadata are disclosed selectively
  ({{selective-disclosure}}): agents reveal only what each peer
  needs. Selective disclosure does not hide the agent's identity
  ({{agent-card}}).
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
* Relays and dialog hosts that need to know only that a request comes
  from a dialog member SHOULD authorize with holder-bound Privacy Pass
  tokens ({{anonymous-relay-authorization}}), so that they do not learn
  which participant acted.
* Payload content SHOULD remain encrypted end-to-end with respect to
  relays unless the relay is explicitly trusted ({{e2e-protection}}).
* Long-lived dialogs SHOULD rotate keys periodically; QUIC provides
  the key material lifecycle.
* Participant descriptors ({{participant-descriptors}}) reach every
  participant. `kind`, `assurance`, and `consent` can reveal that a
  person is present and how they authenticated, and `acts_for` can
  link dialogs. Participants SHOULD declare only the descriptors the
  dialog needs, `acts_for` MUST be an opaque value that differs per
  counterpart unless the principal chooses otherwise. `method` in
  `assurance` names a registered method, never an identifier.
  `related_dialogs`, like `parent_dialog_ids`, links dialogs and is
  withheld where the link should not cross a boundary.
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
UPDATE, JOIN_REQUEST, LEAVE, DECLARE, REVOKE, TERMINATE, SEGMENT,
CANCEL) or STATE_REQUEST in 0-RTT data.

In a dialog between parties of different principals, the controller
acts for one of them. Participant descriptors that a participant
declares are verifiable against its own DECLARE, so the controller
cannot misstate them; descriptors that others observe are attributed,
so each participant weighs them by who made them. The controller can
still delay commits or refuse admissions other than those this
document requires it to accept; a participant that relies on a fair
controller in an adversarial dialog can be the controller itself, or
use a dialog host that neither party operates {{PACE-HTTP}}.

A participant's `kind`, including `human`, is its own claim. Detection
of automation by others is recorded separately, and neither is proof.
Policies that grant more to people than to agents rely on
authentication, not on `kind`.

`result` and `contact_limits` are statements by their sender, not
evidence; a participant relies on the assertions and commitments they
cite, as PACE Authorization describes ({{delegation-approval}}). A join code is a bearer secret for the short time
it is valid: it is single use, rate limited, and admits the redeemer
only as the sponsored participant of the party it was issued to.

A segment hides content from participants of this dialog only when
its content is exchanged in a separate dialog with its own keys
({{segments}}, {{e2e-protection}}); a participant of the segment can
still disclose what it received.

Relays can read and modify payloads that are not protected end to end
({{e2e-protection}}), and they see control messages unless those are
protected too. A deployment that adds an evidence mechanism
({{records}}) lets participants detect modification by relays even
when payloads are not encrypted.

Without key-bound presentations at resumption ({{key-binding}}), a
captured STATE_REQUEST or STATE could be replayed to impersonate a
participant or the controller.

Work in a delegated dialog that continued after its parent was
terminated or its authorization revoked would act without authority.
Lifecycle propagation ({{lifecycle-propagation}}) prevents this when
every controller in the chain is reachable; a controller that is not
leaves its delegated dialogs running until they expire, so delegated
dialogs SHOULD carry an `expires_at` no later than their parent's.
Enforcement outside the agent, such as a hold applied at an
enforcement point in front of the participant (for example, a TRAIL
edge {{TRAIL}}), stops a participant whether or not the participant
or its controller is reachable.

Controller takeover ({{controller-transfer}}) lets the alternate
change the participant set. Participants accept it only from the
designated alternate with verified credentials.

Threats specific to delegation and action approval, such as approval
spoofing by an intermediate agent and confused deputies, are
addressed in PACE Authorization ({{delegation-approval}}).

TODO: further considerations.

# IANA Considerations {#iana}

This document asks IANA to create the following registries in a new
"Protocol for Agent Communication Exchange (PACE)" group, each with
the Specification Required policy {{!RFC8126}}. Each entry has a
value, a description, and a reference.

PACE Result Reasons ({{results}}), with initial values `policy`,
`ineligible`, `suspected-fraud`, `no-stated-purpose`,
`unwanted-contact`, `insufficient-assurance`, `upgrade-declined`,
`principal-declined`, `agreement-reached`, `no-agreement`,
`superseded`, and `consent-withdrawn`, each referencing this document.

PACE Contact Basis ({{contact-basis}}), with initial values
`subscription`, `existing-relationship`, `contract`,
`legal-obligation`, `consent`, and `none`, each referencing this
document.

PACE Assurance Methods ({{participant-descriptors}}), with initial
values `credential`, `cimd`, `resumed`, and `join-code`, each
referencing this document. Values for telephony, such as STIR/SHAKEN
attestation levels, are registered by {{PACE-TEL}}.

This document also asks IANA to register the following entry in the
"Setup Options" registry of {{MoQ-TRANSPORT}}:

| Type | Name | Specification |
|-----:|:-----|:--------------|
| 0x50414301 | pace-version | {{moqt-setup-extensions}} |

This document also asks IANA to register the following entry in the
"WIMSE Message Canonicalization Profiles" registry of {{WPT-MSG}}:

* Profile Name: `pace`
* Description: JCS of a PACE control message with its `credentials`
  member removed
* Reference: {{key-binding}}

This document also asks IANA to register `application/pace-presentation+jwt`
in the "Media Types" registry, for the `typ` header of PACE
presentation JWTs:

* Type name: application
* Subtype name: pace-presentation+jwt
* Required parameters: n/a
* Optional parameters: n/a
* Encoding considerations: binary; a PACE presentation JWT is a JWT, a
  sequence of base64url-encoded values separated by period characters
* Security considerations: {{key-binding}} of this document
* Interoperability considerations: n/a
* Published specification: this document
* Applications that use this media type: PACE participants
* Fragment identifier considerations: n/a
* Additional information: Magic number(s): n/a; File extension(s):
  n/a; Macintosh file type code(s): n/a
* Person and email address to contact for further information: Suhas
  Nandakumar, snandaku@cisco.com
* Intended usage: COMMON
* Restrictions on usage: none
* Author: Suhas Nandakumar, snandaku@cisco.com
* Change controller: IETF

TODO: registries for control operations, ERROR reasons, and dialog
parameters.

--- back

# Example Workflows {#example-workflows}

The examples below share these conventions:

* `D1` to `D7` stand for dialog-ids (UUIDs). `A`, `B`, and `C` are
  agents with agent-ids `agent-a`, `agent-b`, and `agent-c`; other
  agents are named in the example that introduces them.
* Before each example, every agent follows the others
  ({{agent-discovery}}). Each invitee learns the dialog-id from an
  invitation ({{invitations}}), and every participant holds
  SUBSCRIBE_TRACKS on the dialog prefix. The relay therefore forwards
  every new dialog track to the participants, and the steps do not
  repeat the invitations or relay hops.
* Each example lists the tracks by publisher, then the steps. `gen`
  is the dialog generation after a controller operation.
* JSON-RPC messages are shown without the dialog reference
  ({{carrying-dialog-context}}) and, for MCP, without the per-request
  `_meta` fields of {{MCP}}; real messages carry both.

## Delegating a Task with A2A

A asks B to do a task. This example shows the complete dialog
lifecycle; the later examples abbreviate it.

~~~
A publishes:
  ("pace","dialogs",D1,"agent-a") -- "ctrl"        OPEN, UPDATE,
                                                   TERMINATE
  ("pace","dialogs",D1,"agent-a","a2a","request") -- "r1"
                                                   task request
B publishes:
  ("pace","dialogs",D1,"agent-b") -- "ctrl"        ACCEPT
  ("pace","dialogs",D1,"agent-b","a2a","response") -- "r1"
                                                   task result
~~~

1. A publishes OPEN on its `ctrl` track (gen 0, B `invited`) and an
   invitation on `("pace","agents","agent-a","invites") -- "agent-b"`.
2. B reads OPEN on A's `ctrl` track and publishes ACCEPT on its own
   `ctrl` track.
3. A publishes UPDATE (gen 1, B `active`). The dialog is active.
4. A publishes the A2A request on its `request` track `r1`:
   `{"jsonrpc":"2.0","method":"SendMessage","params":{...},"id":"r1"}`,
   with the dialog reference in the message `metadata`
   ({{carrying-dialog-context}}).
5. B publishes the result on its `response` track `r1`.
6. A publishes TERMINATE (gen 2). B could instead have sent LEAVE.

## Calling an MCP Tool

A reads a file through an MCP server, `fs-tool`.

~~~
A publishes:
  ("pace","dialogs",D2,"agent-a") -- "ctrl"
  ("pace","dialogs",D2,"agent-a","mcp","tools","readFile")
      -- "request"                                 tools/call
fs-tool publishes:
  ("pace","dialogs",D2,"fs-tool") -- "ctrl"
  ("pace","dialogs",D2,"fs-tool","mcp","tools","readFile")
      -- "response"                                result
~~~

1. A opens the dialog with fs-tool (OPEN, ACCEPT, UPDATE).
2. A publishes the call as Object 0 of a new group, say Group 7, on
   its `readFile` request track:
   `{"jsonrpc":"2.0","method":"tools/call","params":{"name":"readFile",
   "arguments":{"path":"/data/report.csv"}},"id":"t1"}`.
3. fs-tool publishes the result as the final object in Group 7 of its
   `readFile` response track:
   `{"jsonrpc":"2.0","id":"t1","result":{"resultType":"complete",
   "content":[...]}}`. The JSON-RPC `id` pairs the response with the
   request; the matching Group ID helps relays and recovery
   ({{MCP-MOQT}}).
4. A makes further calls as new groups, or terminates the dialog.

## Long-Running Tool Call with Progress

A asks `code-tool` to generate code. The call takes a while, so
code-tool reports progress while it works and sends the code in the
final result.

~~~
A publishes:
  ("pace","dialogs",D3,"agent-a") -- "ctrl"
  ("pace","dialogs",D3,"agent-a","mcp","tools","generateCode")
      -- "request"                                 tools/call,
                                                   cancellation
code-tool publishes:
  ("pace","dialogs",D3,"code-tool") -- "ctrl"
  ("pace","dialogs",D3,"code-tool","mcp","tools","generateCode")
      -- "response"                                progress, result
~~~

1. A opens the dialog with code-tool (OPEN, ACCEPT, UPDATE).
2. A publishes the call as Object 0 of Group 5 on its `generateCode`
   request track, asking for progress with a `progressToken`:
   `{"jsonrpc":"2.0","id":"g1","method":"tools/call","params":
   {"name":"generateCode","arguments":{"language":"python"},
   "_meta":{"progressToken":"g1"}}}`.
3. code-tool publishes Group 5 of its `generateCode` response track as
   shown in the table below. It sends the progress notifications in
   one subgroup and the result in another, so that each is on its own
   QUIC stream and a large result does not delay the progress
   updates ({{MCP-MOQT}}). A receives each object as soon as it
   arrives, orders them by Object ID, and knows the call is complete
   when the result arrives.
4. To cancel instead, A publishes `notifications/cancelled` as the next
   object in Group 5 of its request track ({{MCP-MOQT}}). code-tool
   stops and ends Group 5 of its response track with a JSON-RPC
   error.

The table lists the objects in code-tool's reply, in Object ID order,
and the subgroup that carries each.

| Object | Subgroup | Content |
|---|---|---|
| 0 | 0 | `notifications/progress`: progress 0 of 3, "Planning modules" |
| 1 | 0 | `notifications/progress`: progress 1 of 3, "Generated parser" |
| 2 | 0 | `notifications/progress`: progress 2 of 3, "Generated tests" |
| 3 | 1 | `tools/call` result with the generated code (142 lines) |
{: title="Objects in code-tool's Reply to the Group 5 Call"}

## Interrupting a Voice Agent

A user's client, `U` (agent-id `user-u`), talks to a voice agent, `V`
(agent-id `agent-v`). V answers by voice while a tool call it made to
`search-tool` is still running. The user cuts in, and V has to stop
speaking and cancel the tool call at once.

~~~
U publishes:
  ("pace","dialogs",D4,"user-u") -- "ctrl"         ACCEPT
  ("pace","dialogs",D4,"user-u") -- "audio"        microphone
V publishes:
  ("pace","dialogs",D4,"agent-v") -- "ctrl"        OPEN, UPDATE,
                                                   CANCEL
  ("pace","dialogs",D4,"agent-v") -- "audio"       speech
  ("pace","dialogs",D4,"agent-v") -- "chat"        reply text
  ("pace","dialogs",D4,"agent-v","mcp","tools","search")
      -- "request"                                 tools/call
search-tool publishes:
  ("pace","dialogs",D4,"search-tool") -- "ctrl"    ACCEPT,
                                                   CANCEL_ACK
  ("pace","dialogs",D4,"search-tool","mcp","tools","search")
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
  ("pace","dialogs",D5,"agent-a") -- "ctrl"        OPEN, UPDATE,
                                                   TERMINATE
  ("pace","dialogs",D5,"agent-a") -- "chat"        assignments
B publishes:
  ("pace","dialogs",D5,"agent-b") -- "ctrl"        ACCEPT
  ("pace","dialogs",D5,"agent-b") -- "chat"        status
  ("pace","dialogs",D5,"agent-b","a2a","task") -- "research-1"
                                                   findings
C publishes:
  ("pace","dialogs",D5,"agent-c") -- "ctrl"        ACCEPT
  ("pace","dialogs",D5,"agent-c") -- "chat"        status
  ("pace","dialogs",D5,"agent-c","a2a","task") -- "analysis-1"
                                                   results
~~~

Because each participant subscribes to the dialog prefix, every agent
receives every other agent's tracks in `D5`; no per-track
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
  ("pace","dialogs",D6,"runtime-r") -- "ctrl"      OPEN, UPDATE,
                                                   TERMINATE
  ("pace","dialogs",D6,"runtime-r","ext","autogen") -- "conv1"
                                                   R's agents' turns
H publishes:
  ("pace","dialogs",D6,"user-h") -- "ctrl"         ACCEPT
  ("pace","dialogs",D6,"user-h") -- "chat"         human input
B publishes:
  ("pace","dialogs",D6,"agent-b") -- "ctrl"        ACCEPT
  ("pace","dialogs",D6,"agent-b","ext","autogen") -- "conv1"
                                                   B's turns
~~~

1. R opens `D6` (gen 0, H and B `invited`), and commits both ACCEPTs in
   one UPDATE (gen 1).
2. R's group chat manager picks the next speaker, as AutoGen does. The
   speaker's message goes out once on its publisher's `conv1` track,
   and the relay delivers it to every other participant.
3. When the manager asks the human, H answers on `chat`.
4. For a nested chat, R opens a child dialog `D7` whose
   `parent_dialog_ids` is `[D6]`, and posts its result back in `D6`.
5. R publishes TERMINATE (gen 2) when the chat ends.

# Acknowledgments

TODO
