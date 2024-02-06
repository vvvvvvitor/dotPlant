extends Sprite2D

signal collector_set
signal bought_product

@export var products: Array[Product]
@export var upgrades: Array[Upgrade]


var collector: Collector:
	set(val):
		collector = val
		collector_set.emit()


func _ready() -> void:
	collector = $Collector


func increase_player_stat(upgrade: Upgrade):
	if collector.stuff_collected >= upgrade.cost:
		var prop = Core.get_player().get(upgrade.property)
		Core.get_player().set(upgrade.property, prop + upgrade.value)
		collector.stuff_collected -= upgrade.cost
		upgrade.cost *= 2
		bought_product.emit()


func buy_product(product: Product) -> bool:
	if collector.stuff_collected >= product.cost:
		if product.quantity > 0:
			var product_instance = product.item.instantiate()
			Core.get_player().inventory.add_item(product_instance)
			collector.stuff_collected -= product.cost
			product.quantity -= 1
			bought_product.emit()
			return true
	return false
