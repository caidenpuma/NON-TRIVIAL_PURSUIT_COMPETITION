# NON-TRIVIAL PURSUIT COMPETITION

## Overview

This project implements autonomous drone algorithms for a competitive predator-prey simulation in MATLAB. The challenge involves creating strategies for both a predator drone attempting to catch prey and a prey drone trying to escape, operating within realistic physical constraints including gravity, drag, fuel limitations, and crash mechanics.

## Project Background

This project simulates the classic "Homicidal Chauffeur Problem" where a fast but less maneuverable predator pursues a slower but more agile prey. Both entities must manage finite fuel reserves and avoid crashing while achieving their objectives.

## System Specifications

### Physical Constraints
- **Predator:**
  - Mass: 100 kg
  - Maximum force: 1,275.3 N
  - Fuel capacity: 500 kJ
  - Crash speed limit: 15 m/s

- **Prey:**
  - Mass: 10 kg
  - Maximum force: 137.34 N
  - Fuel capacity: 50 kJ
  - Crash speed limit: 8 m/s

### Environmental Forces
- Gravity (9.81 m/s²)
- Aerodynamic drag (coefficient: 0.2 Ns²/m²)
- Random wind forces (±0.2mg for each entity)

### Victory Conditions
- Predator wins if it gets within 1m of prey
- Prey wins if it survives 250 seconds
- Either crashes if landing speed exceeds their limit

## Algorithm Strategies

### Predator Strategy
Our predator uses a **predictive pursuit algorithm**:

1. **Motion Prediction:** Calculates prey's future position using current position and velocity
2. **Adaptive Timing:** Reduces prediction time interval (`dt`) when close to prey for more accurate targeting
3. **Vertical Stabilization:** Maintains altitude with upward force component
4. **Crash Prevention:** Applies increasing upward force as ground proximity increases
5. **Smart Refueling:** Executes controlled landing when fuel drops below 150kJ threshold

### Prey Strategy
Our prey employs a **dynamic evasion system**:

1. **Initial Escape:** Applies maximum vertical force for first 5 seconds to gain altitude
2. **Oscillatory Motion:** Uses sine and cosine functions to create unpredictable circular patterns
3. **Distance-Based Behavior:**
   - Far from predator (>50m): Circular motion with trigonometric functions
   - Medium distance (15-50m): Directional escape with periodic trajectory changes
   - Close proximity (<15m): Rapid circular evasion maneuvers
4. **Emergency Refueling:** Quick "nose dive" strategy to minimize refueling time

## Code Structure

### Main Function
```matlab
function F = compute_f_BowerPower(t,Frmax,Fymax,amiapredator,pr,vr,Er,py,vy,Ey)
```

**Parameters:**
- `t`: Current simulation time
- `Frmax`/`Fymax`: Maximum forces for predator/prey
- `amiapredator`: Boolean flag for predator/prey mode
- `pr`/`py`: Position vectors [x; y]
- `vr`/`vy`: Velocity vectors [vx; vy]
- `Er`/`Ey`: Remaining energy levels

**Returns:**
- `F`: Force vector [Fx; Fy] to be applied

### Key Features
- **Crash Prevention:** Ground avoidance using inverse altitude relationship
- **Fuel Management:** Automatic refueling when energy drops below thresholds
- **Adaptive Behavior:** Dynamic strategy changes based on proximity and game state

## Performance Results

### Competition Performance
- **vs Peer Group:** High success rate, won majority of matchups
- **vs Professor's Code:** 2 wins out of 8 attempts (challenging benchmark)
- **Notable Issues:** Predator sometimes followed closely without catching in midair

### Strengths
- Effective prediction algorithm for pursuit
- Robust crash prevention system
- Successful refueling strategies
- Good balance between predator and prey performance

### Areas for Improvement
- Predator could attack from above to force prey toward ground
- More calculated (vs random) direction changes for prey
- Smaller prediction intervals for closer encounters
- Direct position component in addition to velocity prediction

## Usage Instructions

1. **Setup:** Place the `MATLAB_CODE.m` file in your MATLAB working directory
2. **Testing:** Use the provided `function_tester.p` to validate implementation
4. **Customization:** Modify strategy parameters within the conditional blocks

## Technical Implementation

### Crash Prevention
```matlab
% Ground avoidance force increases with proximity
F_ground = 1000/(altitude + 0.25) * [0; 1]
```

### Refueling Logic
```matlab
% Critical height calculation for safe landing
h_crit = 1.5 * (0.5 * mass * speed^2) / (max_force - mass * gravity)
```

### Prediction Algorithm
```matlab
% Predict future positions for interception
predicted_position = prey_position + prey_velocity * dt
predicted_predator = predator_position + predator_velocity * dt
direction = (predicted_position - predicted_predator) / norm(...)
```

## Dependencies

- MATLAB R2019b or later
- Basic MATLAB toolboxes (no specialized requirements)
