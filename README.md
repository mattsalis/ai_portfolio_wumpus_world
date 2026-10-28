
# AI Robot Vacuum Agent — Prolog

## Overview

This project is a first-year university AI coursework project developed using **Prolog**. It implements a rule-based intelligent agent that navigates a simulated 4×4 grid environment representing a home.

The agent must interpret information about its surroundings, avoid hazards and obstacles, locate dirt, and make decisions based on a set of logical rules.

The project explores fundamental Artificial Intelligence concepts, including knowledge representation, logical reasoning, decision-making, and partially observable environments.

## Environment

The environment consists of a 4×4 grid containing:

- **Robot agent:** Starts at position `(1,1)`, facing east.
- **Dirt:** Locations the robot needs to identify and clean.
- **Liquid hazard:** A hazardous tile that the robot must avoid.
- **Stairs:** A dangerous area that the robot needs to recognise.
- **Furniture:** Obstacles that restrict the robot's movement.

The robot cannot directly observe everything in the environment. Instead, it uses percepts to gather information about nearby cells.

## AI Concepts

### Rule-Based Reasoning

The agent uses predefined logical rules to interpret percepts and determine appropriate actions.

### Partial Observability

The agent does not have complete information about the entire environment at all times. It must use the information available from its surroundings to make decisions.

### Knowledge Representation

Facts represent information about the environment, including the agent's position, hazards, obstacles and dirt locations.

### Percept-Based Decision-Making

The agent uses environmental clues to identify potential hazards and relevant locations:

- **Moisture:** Indicates proximity to liquid.
- **Edge warnings:** Indicate proximity to stairs.
- **Rubble:** Indicates proximity to dirt.

## Technologies Used

- **Prolog** — Logic programming and rule-based AI.
- **Visual Paradigm** — Used to create the environment diagram.

## Learning Outcomes

This project helped develop an understanding of:

- Implementing logical rules in Prolog.
- Representing knowledge using facts and predicates.
- Designing an agent that operates in a partially observable environment.
- Using percepts to support decision-making.
- Understanding the strengths and limitations of deterministic, rule-based AI.

## Project Context

Developed as part of first-year Computing and AI coursework at Loughborough University.
