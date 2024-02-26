extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHitbox") var hurtboxType = 0
@onready var collision = %CollisionShape2D
@onready var disableTimer = %DisableTimer

signal hurt(damage, angle, knockback_amount)

func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match hurtboxType:
				0: #Cooldown
					collision.call_deferred("set", "disabled", true)
				1: #HitOnce
					pass
				2: #DisableHitbox
					if area.has_method("tempdisable"):
						area.tempdisable()
			var damage = area.damage
			var angle = Vector2.ZERO
			var knockback = 1
			if not area.get("angle") == null:
				angle = area.angle
			if not area.get("knockback_amount") == null:
				knockback = area.knockback_amount
			
			emit_signal("hurt", damage, angle, knockback)
			if area.has_method("mob_hit"):
				area.mob_hit(1)

func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
