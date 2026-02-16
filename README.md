# Dynamic-analysis-of-a-two-mass-system-connected-by-a-rope
MATLAB simulation of a coupled table–mass system solved using ode45, including trajectory visualization and animation.
```markdown
# Dynamic Analysis of a Two-Mass System Connected by a Rope

## Project Overview

This project presents a comprehensive dynamic analysis of a mechanical system consisting of two masses connected by a light, inextensible rope passing through a small hole at the center of a circular table and a movable pulley beneath it.

- **Mass A** moves on the surface of a circular table.
- **Mass B** hangs vertically below the table.
- The rope is assumed to be massless and inextensible.
- The pulley is ideal (massless and frictionless).
- The table surface is considered under both frictionless and frictional conditions.

The governing differential equations of motion are derived analytically and solved numerically using MATLAB’s `ode45` solver.

---

## System Description

| Parameter | Value |
|------------|--------|
| Table radius | 1.3 m |
| Initial radius of Mass A | 0.75 m |
| Initial velocity of Mass A | 5 m/s |
| Hole diameter | 0.10 m |
| Number of rope segments (n) | 2 |

Due to the constant rope length constraint:

> As Mass A moves radially inward, Mass B moves vertically downward proportionally.

---

## Methodology

1. Derivation of governing equations using:
   - Newton’s Second Law
   - Radial and tangential coordinates
   - Geometric rope constraint
2. Reformulation into a system of first-order ordinary differential equations (ODEs).
3. Numerical solution using MATLAB’s `ode45`.
4. Post-processing including:
   - Animation of Mass A motion
   - Plots of:
     - Speed of Mass A vs. time
     - Vertical position of Mass B vs. time
     - Rope tension vs. time

The simulation time span was set to 20 seconds. In several cases, the simulation terminated earlier when Mass A reached the central hole.

---

# Part A: Frictionless Surface

### Cases Investigated

- \( m_B = 6 \) kg  
- \( m_B = 15 \) kg  
- \( m_B = 50 \) kg  

### Results Summary

#### Case 1: mB = 6 kg
- Gradual reduction in velocity
- Mild oscillations in rope tension
- Relatively stable motion
- Mass A slowly migrates toward the center

#### Case 2: mB = 15 kg
- Faster velocity decay
- Increased oscillatory behavior
- Higher steady-state tension
- System approaches dynamic equilibrium

#### Case 3: mB = 50 kg
- Rapid inward acceleration of Mass A
- Large tension fluctuations
- System instability
- Mass A quickly falls into the central hole

### Conclusion (Part A)

Increasing the hanging mass:

- Initially improves system stability.
- Beyond a critical value, destabilizes the system.
- Excessive hanging mass leads to rapid inward acceleration.
- Centrifugal force becomes insufficient to counteract tension.

---

# Part B: Rough Surface (Kinetic Friction Included)

### Parameters

- \( m_B = 6 \) kg  
- \( \mu_k = 0.03 \)  
- \( \mu_k = 0.15 \)  
- \( \mu_k = 0.90 \)  

### Results Summary

#### Case 1: μ = 0.03
- Behavior closely resembles frictionless case.
- Minor energy dissipation.
- Slight damping of oscillations.

#### Case 2: μ = 0.15
- Noticeable velocity reduction.
- Faster stabilization.
- Reduced oscillation amplitude.
- Earlier inward motion.

#### Case 3: μ = 0.90
- Strong frictional dominance.
- Motion nearly suppressed.
- Rope tension rapidly approaches zero.
- Minimal displacement of Mass B.

### Conclusion (Part B)

Increasing the coefficient of kinetic friction:

- Enhances energy dissipation.
- Reduces oscillatory behavior.
- Decreases rope tension magnitude.
- For sufficiently high friction, completely suppresses motion.

---

# Part C: Specific Parameter Scenario

### Given Parameters

- \( m_A = 5 \) kg  
- \( m_B = 4 \) kg  
- \( \mu_k = 0.7 \)  
- \( v_0 = 3 \) m/s  

### Results

1. **Final Position of Mass A**
   - Brief initial motion.
   - Rapid deceleration.
   - Ultimately moves toward the center and falls through the hole.

2. **Final Position of Mass B**
   - Initial slight upward motion (~10 cm).
   - Subsequent downward displacement (~50 cm).
   - Net displacement ≈ 40 cm downward.

3. **Final Rope Tension**
   - Approaches zero as motion ceases.

### Interpretation

High friction significantly dominates system dynamics:
- Rapid energy dissipation.
- Short-lived motion.
- Inability to sustain circular movement.
- Rope tension insufficient to maintain dynamic equilibrium.

---

# Key Physical Insights

- Rope tension depends on both gravitational force and centripetal requirements.
- System stability is highly sensitive to the ratio \( m_B / m_A \).
- Friction introduces irreversible energy dissipation.
- Excessive hanging mass destabilizes circular motion.
- High friction prevents effective force transmission through the rope.

---

# Software and Tools

- MATLAB
- `ode45` ODE solver
- Custom animation routines using MATLAB plotting tools

```
