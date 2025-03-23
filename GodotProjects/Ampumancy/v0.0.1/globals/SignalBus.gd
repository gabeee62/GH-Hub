extends Node

signal no_spell()
signal death()

signal spell_cast(spell: Node2D)
signal reparent_spell_particles(particles: GPUParticles2D)
signal kill_spell_particles(particles: GPUParticles2D)
