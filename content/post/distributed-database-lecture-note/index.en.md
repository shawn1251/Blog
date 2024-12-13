---
title: "Distributed Database System Lecture Note"
date: 2024-07-31T00:00:00+08:00
draft: false
description: ""
type: "post"
tags: []
categories : ["database"]
tags: ["LectureNote"]
---

[Mind Map](./file/Distributed%20Database%20System.pdf)

Instructor’s name: Ali Safari \
Textbook: Principles of Distributed Database Systems, 4th edition, M. Tamer Özsu and Patrick Valduriez, 
Springer, 2020, ISBN 978-3-030-26252-5

##  Distributed and Parallel Database Design

### fragmentation

- correctness

	- completness

		- each data in relation can also be found after fragmentation

	- reconstruction

		- by JOIN, the fragment can recovery to the original relation

	- disjointness

		- data in one fragment should not also be in other fragment

- type

	- horizontal fragmentation (HF

		- primary horizontal (PHF

			- key points

				- simple prdicate

					- predicate: key + operator + value

						- eg. salary > 1000

				- minterm predicate

					- all possible combination of predicate

						- eg. loc = "France" ^ salary > 1000

				- minterm selectivities, sel(mi)

					- the percentage of records that minterm selected

				- access frequency, acc(qi)

					- how many times the same query asked by different user

				- cardinality, card(R)

					- number of rows

			- COM_MIN algorithm

				- input: a relation R, a set of simple predicates Pr

				- output: a "complete", "minimal" set of simple predicates Pr'

			- PHORIZONTAL Algorithm

				- input: a relation R, a set of predicates Pr

				- output: a set of minterm predicates M according to which relation R is to be fragmented

		- derived horizontal (DHF

			- Based on the fragments created by PHF, apply similar fragmentation to other related relations.

			- eg. after PHF, we divide "PAY" to 2 fragments. There is also a relation "EMP" related with "PAY". We can also divide "EMP" by the same rule

	- vertical fragmentation (VF

		- affinity matrix

			- calculate by access frequency matrix and usage matrix

		- bond energy algorithm (BEA

			- input: the AA matrix (attribute affinity)

			- output: the CA matrix(clustered affinity matrix)

			- by changing the order what's the most contribution I can get?

			- find the best order for columns

	- hybrid fragmentation

		- apply both horizontal and vertical

		- reconstruction

			- vertical: join

			- horizontal: union

### data distribution

- allocation alternatives

	- non-replicated

		- each fragment resides at only one site

	- replicated

		- fully replicated

			- each fragment at each site

		- partially replicated

			- each fragment at some of the sites

		- if read-only queries >> update queries, replication is good

- fragment allocation

	- problem: fragments, network, application

	- find the optimal distribution

		- minimal cost

		- performance

		- constraint

			- response time

			- storage

			- processing

	- decision variable

		- Xij. 1 if fragment i store in at Site j. 0 otherwise

	- both FAP and DAP are NP-complete

		- heuristic based on. about finding the best combination

### combined approach

## transaction

### all operations as one unit. whole or nothing

### ACID

- Atomicity

	- one unit

- Consistency

- Isolation

- Durability

### concurrent execution

- increase processor and disk utilization (I/O no need CPU)

- reduced average response time

- important: multi tasks run in the but the result should be the same as serial running

- validation

	- except read - read, all the others are conflict

	- try to move commands to see if they can be restored to the serial running format   

	- if the commands are conflict, it should not be moved

### serializability

- view serializability

	- not strict

	- the initial, update, final result should be the same as serial schedule

	- check a schedule is serializable is NP-Complete problem

- conflict serializability

	- more strict

		- conflict serializable is the sub set of serializable

	- there is no any conflict between transactions(R/W, W/W)

	- test method

		- swap non-conflicting instruction

			- If a schedule S can be transformed into a schedule S’ by a series of swaps of non-conflicting instructions, we say that S and S’ are conflict equivalent

			- a schedule S is conflict serializable if it is conflict equivalent to a serial schedule


		- precedence graph

			- transaction => node

			- conficts => edge

			- if graph has cycle, means not serializable

				- can do topological sorting

### failure

- rollbacks

	- cascading rollback

		- 1 transaction failure, all the other transactions rollback

- recoverable schedule

	- ensure data consistency

	- reading transaction can read data which not commit yet, but cannot commit before the writing transaction

- cascadeless schedules

	- enhace recoverable schedule

		- is the subset of recoverable

	- transaction can only read data which is commited

	- the schedule which try to avoid cascading rollbacks

## concurrency control

### concept

- the mechanism provided by the db system

- serial schedule is recoverable and cascadeless

- have to trade off between serial schedule and concurrent schedule

- ensure schedule is conflict or view serializable

- ensure the schedule is  rcoverable and preferably cascadeless

- to achieve these purpose, it needs a "protocol" to assure serializability

### protocols

- lock-based protocols

	- exclusive (X) mode

		- cannot add any other lock

		- only one transaction can R/W data

	- shared (S) mode

		- can add more shared lock

		- multiple read transaction can read the data at the same time

	- two-phase locking protocol

		- grow-lockpoint-shrink

			- grow

				- the transaction acquire all the lock before access without release

				- can convert lock-S to lock-X (upgrade)

			- shrink

				- start to releasing locks, cannot acquire any new lock

				- can convert lock-X to lock-S (downgrade)

		- type

			- strict two-phase locking

				- keep all the X-lock till commit/abort

			- rigorous two-phase locking

				- keep all the locks till commit/abort

		- ensure conflict-serializable

		- cannot avoid deadlock

		- startegy

			- read:
  if lock:
    read()
  else:
    if lock-X:
      wait()
    grant lock-S
    read()

			- write:
  if lock-X:
    write()
  else:
    if other locks:
      wait()
    if lock-S:
      upgrade to lock-X
    else:
      grant lock-X
    write()

	- lock table

		- maintain by lock manager

		- lock table, record the type of lock granted or requested

		- like hash table

		- validate before grant new lock

			- if there are multiple locks, the last one can only be lock-X

- Graph based protocol

	- alternative to two phase locking

	- Tree protocol

		- Only exclusive locks are allowed

		- once unlock, cannot relock

		- conflict serializable

		- not gurantee recoverability

		- no deadlock

### deadlock prevention strategies

- wait-die

	- older may wait for younger release

	- younger never wait, rolled back instead

- wound-wait

	- older can force rollback younger

	- younger may wait for older

	- fewer rollback than wait-die

- timeout-based schemes

### deadlock detection

- wait-for graph

	- Ti -> Tj: Ti is waiting for a lock held by Tj

	- deadlock if there is a cycle

### deadlock recovery

- total rollback

- partial rollback

	- difficult

### multiple granularity

- can be represented as a tree

- locks a node, also locks all the children node

- Fine granularity: high concurrency, lower in tree

- Coarse granularity: low concurrency, higher in tree

- intention lock modes

	- 3 more lock mode than S, X

	- intention-shared (IS)

		- same as S, but locking at a lower level

	- intention-exclusive (IX)

	- shared and intention-exclusive (SIX)

	- allow a higher level node to be locked without having to check all descendent nodes

	- the compatibility matrix for all lock modes

### Timestamp-based protocols

- timestamp order = serializability order

- Timestamp-ordering protocol

	- WTS(Q) (W-timestamp): the largest timestamp of any transaction that executed "write(Q)"

	- RTS(Q) (R-timestamp): the largest timestamp of any transaction that executed "read(Q)"

	- algorithm

		- Ti = Read(Q)

			- if TS(Ti) < WTS(Q), Reject
(Ti needs the value that was already overwritten)

			- if TS(Ti) >= WTS(Q), execute, RTS(Q) update to max(RTS(Q), TS(Ti))
(Read after latest update is accepted)

		- Ti = Write(Q)

			- if TS(Ti) < RTS(Q), Reject
(Ti produce a value that was  needed previously)

			- if TS(Ti) < WTS(Q), Reject
(Ti try to write an obsolete value)

			- else, WTS(Q) update to TS(Ti)

## transaction processing-2

### Distributed TM Architecture

### serializability 

- the condition that global transaction is serializable

	- each local history should be serializable

	- two conflicting operations should be in the same relative order in all of the local histories where they appear together

### concurrency control algorithms

- Pessimistic

	- Two-Phase Locking-based (2PL)

		- centralized 2PL

			- only one 2PL scheduler in the distributed system

			- lock requests are issued to the central scheduler

			- pros: Simple

			- cons: reliability, bottle neck

		- distributed 2PL

### Deadlock

- locking-based algorithm may cause deadlocks

- TO based algorithm that involve waiting may cause deadlocks

- wait-for graph

	- Ti waits for Tj 

	- Ti --> Tj

## Query Processing

### for one query, there may be several strategies

- optimization: calculate the cost, then choose the lowest one

	- access cost

	- transfer cost

- example

- problem

- Cost of Alternatives

### Complexity of relational operations

- Select
Project

	- O(n)

- Project (eliminate duplicate)
Group

	- O(n * log n)

	- sorting + check the array sequentially

- Join
Semi-Join
Division
Set

	- O(n * log n)

- Cartesian Product

	- O(n^2)

### Query Processing Methodology


- 1. Query Decomposition

	- input: Calculus query on global relations

	- Normalization

	- Analysis

	- Simplification

	- Restructing

	- output: Algebraic query

- 2. Data Localization

	- input: Algebraic query on distributed relations

	- Localization program

	- Reduction based on the fragmentation strategy

		- PHF

			- Select

				- Because we have already divided the relations base on some rule. Only have to access the relations that have intersection with the query 

			- Join

				- Distribute join over union

				- (R1 U R2)⋈S  => (R1⋈S) U (R2⋈S)


				- by distribute 1 join to multiple join, we can eliminate some of them that have no intersection with the query

		- VF

			- find useless intermiediate relations

		- DHF

			- mix the PHF-Select and PHF-Join

			- example


			- query

			- 1. eliminate by Selection

			- 2. join over union

			- 3. eliminate the empty intermediate relations

		- Hybrid Fragmentation

			- remove empty relations by selection on HF

			- remove useless relations by projection on VF

			- distribute joins over unions to isolate and remove useless joins

	- output: Fragment query

- 3. Distributed Query Optimization

	- input: Fragment query

	- Find the best global schedule

	- query optimization process

		- Search Space

			- The set of equivalent alebra expressions

			- Join Trees

				- Linear join tree

				- Bushy join tree

		- Cost Model

			- I/O cost + CPU cost + communication cost

		- Search Algorithm 

			- exhaustive search / heuristic algorithm

			- how to "move" in the search space

			- Deterministic

				- start from base relations and build  plans by adding one relation at each step

				- DP: BFS

				- Greedy: DFS

			- Randomized

				- trade optimization time for execution time

				- iterative improvement

