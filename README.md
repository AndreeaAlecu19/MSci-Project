# Mathematical modelling of blood flow in vascular networks in health and disease

## MSci Project


In this repository we investigate the blood flow in a cylindrical blood vessel and in a microvascular network, where the flow is assumed to be firstly Newtonian, and secondly, a yield stress fluid.

1. Blood flow in a single channel - Newtonian
2. Blood flow in a single channel - non-Newtonian (Bingham fluid)
3. Blood flow in a microvascular network - Newtonian
4. Blood flow in a microvascular network - non-Newtonian (Bingham fluid)


## Functionality of the files
In this folder, we have 6 MATLAB files, all handling different aspects of the enitre project:

- Blood_system_plot.m - Plots the microvascular system where we have a branching of a channel.

- Newtonian_single_vessel_vel_profile.m - Plots the Poiseuille velocity profile in a pipe

- Newtonian_microvascular_network.m - Plots the pressure in the network, the flow rate in the experimental channel for varying its vascular resistance. We also use eperimental data to find the flow rate for different level of oxygen in the blood.

- Non_Newtonian_Bingham_single_vessel_vel_profile.m - Plots the velocity profile of a Bingham fluid in a pipe, for different values of yield stress.

- Microv_network_Bingham_flow_rates.m - Plots the flow rates in all the blood vessels when we increase the inflow pressure. We also plot the behaviour of the wall shear stress in each channel, as well as the evolution of the pressure at the bifurcation node.

- Non-Newtonian_Bingham_Microv__network_tau02_changed.m - Plots the flow rates in all the vessels when the yield stress in the experimental channel is increased.


## Experimental data
For the experimental results in Newtonian_microvascular_network.m, we obtained the input parameters from our collaborators from the US.


## Reproducing the results:
Each file can be run independetly of each other, and they take at most 30 seconds to produce the results, depending on your machine. 
