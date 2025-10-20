---
title: "Media over QUIC Transport (MOQT) for Agent-to-Agent Protocol"
abbrev: "A2A over MOQT"
category: std

docname: draft-a2a-moqt-transport-00
submissiontype: IETF
number:
date: 2025-10-17
consensus: true
v: 3
area: "Applications and Real-Time"
workgroup: "Media Over QUIC"
keyword:
 - agent-to-agent
 - MOQT
 - AI agents
 - real-time communication

venue:
  group: "Media Over QUIC"
  type: "Working Group"
  mail: "moq@ietf.org"
  arch: "https://mailarchive.ietf.org/arch/browse/moq/"
  github: "ietf-wg-moq/draft-a2a-moqt-transport"
  latest: "https://ietf-wg-moq.github.io/draft-a2a-moqt-transport/draft-a2a-moqt-transport.html"

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
  RFC8174:
  RFC9000:
  RFC8446:
  MoQ-TRANSPORT: I-D.draft-ietf-moq-transport
  A2A:
    title: "Agent-to-Agent Protocol Specification"
    date: 2025
    author:
    - org: A2A Project
    target: https://a2a-protocol.org/latest/specification/

informative:
  RFC7540:
  WebTransport:
    title: "The WebTransport Protocol Framework"
    date: 2023-08
    author:
    - ins: V. Vasiliev
    seriesinfo:
      RFC: 9297
    target: https://www.rfc-editor.org/rfc/rfc9297

--- abstract

This document specifies how the Agent-to-Agent (A2A) protocol can be 
transported over Media over QUIC Transport (MOQT). MOQT provides a 
publish/subscribe model over QUIC that enables efficient real-time 
communication between AI agents, supporting the A2A protocol's 
requirements for discovery, negotiation, and collaboration while 
leveraging MOQT's streaming capabilities and built-in prioritization mechanisms.

--- middle

# Introduction

The Agent-to-Agent (A2A) protocol enables communication between AI agents 
across different platforms and frameworks. Currently, A2A supports three 
transport protocols: JSON-RPC 2.0 over HTTP(S), gRPC, and HTTP+JSON/REST. 
This document defines a fourth transport option using 
Media over QUIC Transport (MOQT) to provide enhanced real-time streaming 
capabilities for agent interactions.

MOQT is designed for media streaming over QUIC and WebTransport, providing a 
publish/subscribe model with hierarchical data organization. While originally 
intended for media applications, MOQT's streaming model and prioritization 
capabilities make it well-suited for real-time agent communication scenarios.

## Requirements Language

{::boilerplate bcp14-tagged}

# A2A Transport Requirements

According to the A2A specification, all transport protocols MUST provide 
functional equivalence and support the following capabilities:

* Secure communication over encrypted channels
* Request/response messaging patterns
* Streaming data delivery capabilities
* Error handling and status reporting
* Agent discovery and capability negotiation
* Support for various data types (text, JSON, files)

~~~
   A2A Protocol Layer
   ┌─────────────────────────────────────────────────────────────┐
   │  Agent Discovery │ Capability Exchange │ Task Collaboration │
   └─────────────────────────────────────────────────────────────┘
                                 │
   ┌─────────────────────────────────────────────────────────────┐
   │                    MOQT Transport Layer                     │
   │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
   │  │ PUB/SUB     │  │ Streaming   │  │ Priority/QoS        │  │
   │  │ Model       │  │ Support     │  │ Management          │  │
   │  └─────────────┘  └─────────────┘  └─────────────────────┘  │
   └─────────────────────────────────────────────────────────────┘
                                 │
   ┌─────────────────────────────────────────────────────────────┐
   │                    QUIC/WebTransport                        │
   │        ┌─────────────┐              ┌─────────────┐         │
   │        │ Encryption  │              │ Multiplexing│         │
   │        │ (TLS 1.3)   │              │ & Flow Ctrl │         │
   │        └─────────────┘              └─────────────┘         │
   └─────────────────────────────────────────────────────────────┘
~~~

# MOQT Transport Mapping

## Connection Establishment

A2A agents using MOQT transport MUST establish a QUIC or WebTransport 
connection with the ALPN value "moq-00" as defined in the MOQT specification. 
The connection setup follows this sequence:

~~~
Agent A                                                   Agent B
   |                                                        |
   |──── QUIC Connection (ALPN: "moq-00") ────────────────▶ |
   |◄─── QUIC Connection Established ───────────────────────|
   |                                                        |
   |──── MOQT CLIENT_SETUP ────────────────────────────────▶|
   |◄─── MOQT SERVER_SETUP ─────────────────────────────────|
   |                                                        |
   |──── A2A Agent Registration ───────────────────────────▶|
   |◄─── A2A Capability Exchange ───────────────────────────|
   |                                                        |
   |◄═══ A2A Protocol Exchang ═════════════════════════════▶|
~~~

During the MOQT setup phase, agents MUST negotiate the following 
A2A-specific extensions:

* a2a-version: Supported A2A protocol version
* a2a-capabilities: Agent capabilities and supported operations  
* a2a-auth: Authentication and authorization tokens

## Track Organization

A2A protocol messages are mapped to MOQT tracks using a hierarchical 
namespace structure. Each agent creates tracks for different message categories:
Tracks are organized as follows:

Request Tracks:
: Used for A2A request messages, organized by category and 
  action (e.g., discovery/capabilities, tasks/execute).

Response Tracks:
: Used for A2A response messages, organized by request ID for correlation.

Stream Tracks:
: Used for long-running streaming operations like task execution 
  updates or file transfers.

Notification Tracks:
: Used for asynchronous notifications and events.

## Message Serialization

A2A protocol messages are serialized as JSON and encapsulated within 
MOQT objects. Each MOQT object contains:

~~~
MOQT Object Structure for A2A:

┌─────────────────────────────────────────────────────────┐
│                 MOQT Object Header                      │
│  Track ID │ Group ID │ Object ID │ Priority │ ....      │
└─────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────┐
│                 A2A Message Payload                     │
│  ┌─────────────────────────────────────────────────────┐│
│  │              JSON A2A Message                       ││
│  │  {                                                  ││
│  │    "jsonrpc": "2.0",                                ││
│  │    "method": "category/action",                     ││
│  │    "params": { ... },                               ││
│  │    "id": "request-id"                               ││
│  │  }                                                  ││
│  └─────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────┘
~~~

The A2A message format remains unchanged from the JSON-RPC 2.0 specification, 
ensuring compatibility with existing A2A implementations.

## Priority and Quality of Service

MOQT's built-in priority system is mapped to A2A message urgency:

Priority 1 (Highest):
: Emergency and critical error responses

Priority 2:
: Real-time interaction responses and notifications

Priority 3:
: Standard request/response messages

Priority 4:
: Discovery and capability exchange messages

Priority 5 (Lowest):
: Background updates and non-critical notifications


# Protocol Operations

## Agent Discovery

Agent discovery over MOQT uses a Subscribe Namespace pattern where 
agents subscribe to the `<session_context_id>/discovery`  namespace prefix and 
publish their agent announcements using 
the `<session_context_id>/discovery/agent-{id}` pattern to reach all 
subscribers.

~~~
Discovery Flow:

Agent A                       MOQT Network                    Agent B
   |                              |                             |
   |─ SUBSCRIBE_NAMESPACE────────▶|                             |
   |  (<..>/discovery)            |◄─ SUBSCRIBE_NAMESPACE───────┤
   |                              |   (<..>/discovery)          |
   |                              |                             |
   |─ PUBLISH(/discovery/         |                             |
   |   agent-a) ─────────────────▶|─ PUBLISH(/discovery/        |
   |                              |agent-a) ───────────────────▶|
   |                              |                             |
   |                              |◄─ PUBLISH(/discovery/       |
   |                              |    agent-b) ────────────────┤
   |◄─ PUBLISH(/discovery/        |                             |
   |   agent-b) ──────────────────|                             | 
   |                              |                             |
   |                              |                             |
   |◄── Object(Agent B caps) ─────|── Object(Agent A caps) ────▶|

~~~

## Request/Response Patterns

A2A request/response interactions are implemented using coordinated 
PUBLISH/SUBSCRIBE operations:

1. Server agent uses SUBSCRIBE_NAMESPACE to subscribe to `<..>/server-agent-{id}` Namespace prefix
2. Client agent sends PUBLISH message on `<..>/server-agent-{id}/request` track
3. Client agent subscribes to `<..>/server-agent-{id}/response` track  
4. Client agent publishes OBJECT on `<..>/server-agent-{id}/request` track
5. Server agent receives OBJECT via its namespace subscription
6. Server agent publishes OBJECT on `<..>/server-agent-{id}/response` track
7. Client agent receives response OBJECT via its subscription

~~~
Request/Response Flow:

Client Agent                MOQT                   Server Agent
     |                        |                        |
     |                        |◄(1) SUBSCRIBE_NAMESPACE|
     |                        | (<..>/server-agent-{id})
     |─(2) PUBLISH(           |                        |
     |  /server-agent-{id}/   |                        |
     |  request) ────────────▶|                        |
     |                        |─(2) PUBLISH(           |                        
     |                        |  /server-agent-{id}/   |                        
     |                        |  request) ────────────▶|                 
     |─(3) SUBSCRIBE(         |                        |
     |  /server-agent-{id}/   |                        |
     |  response) ───────────▶|                        |
     |                        |─(3) SUBSCRIBE(         |                        
     |                        |  /server-agent-{id}/   |                        
     |                        |  response) ───────────▶|                        
     |─(4) OBJECT(            |                        |
     |  /server-agent-{id}/   |                        |
     |  request) ────────────▶|───────────────────────▶|
     |                        |                        |
     |                        |◄(5) OBJECT(            |
     |                        |  /server-agent-{id}/   |
     |                        |  response) ────────────|
     |◄(6) OBJECT(            |◄───────────────────────|
     |  /server-agent-{id}/   |                        |
     |  response) ────────────|                        |
     |                        |                        |

~~~

## Streaming Operations

Long-running A2A operations like task execution or file transfer 
utilize MOQT's streaming capabilities. Stream tracks carry incremental 
updates as separate MOQT objects.

~~~
Streaming Task Execution:

Client                     MOQT Stream                  Server
  |                           |                           |
  |─ SUBSCRIBE(               |                           |
  |  /server-agent-{id}/      |                           |
  |  task_{id}) ─────────────▶|                           |
  |                           |─ SUBSCRIBE(               |                       
  |                           |  /server-agent-{id}/      |                        
  |                           |  task_{id}) ─────────────▶|                     
  |                           |◄─ OBJECT(                 |
  |                           |  /server-agent-{id}/      |
  |                           |  task_{id}, progress-1) ──|
  |◄─ Progress Update 1 ──────|                           |
  |                           |◄─ OBJECT(                 |
  |                           |  /server-agent-{id}/      |
  |                           |  task_{id}, progress-2) ──|
  |◄─ Progress Update 2 ──────|                           |
  |                           |◄─ OBJECT(                 |
  |                           |  /server-agent-{id}/      |
  |                           |  task_{id}, result) ──────|
  |◄─ Final Result ───────────|                           |
  |                           |◄─ OBJECT(                 |
  |                           |  /server-agent-{id}/      |
  |                           |  task_{id}, complete) ────|
  |◄─ Stream Complete ────────|                           |

~~~


# Benefits of MOQT for A2A

MOQT provides significant advantages over traditional A2A transports, 
particularly for real-time agent collaboration and large-scale deployments:

## Real-time Communication Benefits

* Low-latency streaming enables immediate agent response to changing conditions
* Priority-based message delivery ensures critical communications are not delayed
* Streaming object delivery allows agents to act on incomplete data when appropriate
* Built-in flow control prevents agent overload during high-volume interactions

## Scalability Benefits

MOQT's publish/subscribe model creates powerful network effects for 
multi-agent environments:

* One-to-many broadcasts enable efficient agent coordination
* Subscription-based interest management reduces unnecessary traffic
* Dynamic agent discovery scales to thousands of participants
* Relay-based distribution prevents connection explosion in mesh networks


## Reliability and Resilience

MOQT provides enhanced reliability features critical for production 
agent deployments:

* Connection migration maintains agent sessions during network changes
* Automatic retry and recovery mechanisms handle transient failures
* Graceful degradation allows agents to continue operating with reduced capabilities
* Quality of Service controls prevent cascade failures in agent networks

# MOQT Relay Infrastructure for A2A

MOQT relays provide critical infrastructure benefits for 
large-scale A2A deployments, enabling efficient message distribution and caching.

## Relay Network Architecture

MOQT relays form a hierarchical distribution network that optimizes A2A 
message delivery across geographic and organizational boundaries:

This hierarchical structure provides:

* Regional optimization with local agent clusters
* Global connectivity for cross-region agent collaboration
* Load distribution to prevent single points of failure
* Configurable routing policies based on agent requirements

## Message Caching Benefits

MOQT relays can implement intelligent caching strategies optimized for 
A2A communication patterns. 

The most frequently accessed and time-sensitive 
data with time-to-live values are measured in seconds. This includes 
real-time agent responses, live data streams, and status updates that 
require immediate availability. These messages are kept in high-speed 
memory to ensure minimal latency for active agent interactions.

Another layer can serve as an intermediate storage tier with 
time-to-live values measured in minutes. This layer contains agent 
capability profiles, metadata about agent configurations, and results 
from common queries that are accessed regularly. The caching layer can provide
a balance between  accessibility and resource utilization.

Also for archives of historical data with extended retention 
periods measured in hours or days, can employ a different storage strategy. 
Examples data might include historical logs, 
archived computation results, compliance audit data, and debug traces that 
may be needed for analysis or regulatory purposes but are accessed infrequently.


--- back

# Acknowledgments
