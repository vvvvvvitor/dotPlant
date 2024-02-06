extends FlowContainer

const PRODUCT_PANEL: PackedScene = preload("res://res/scenes/nodes/ui/printer/product_panel.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await owner.collector_set
	build_products()



func build_products():
	var collector: Collector = owner.collector

	for product: Product in owner.products:
		var product_panel_instance = PRODUCT_PANEL.instantiate()
		product_panel_instance.icon = product.icon
		product_panel_instance.text = "$" + str(product.cost)
		product_panel_instance.tooltip_text = product.name + "\n" + product.description
		product_panel_instance.set_meta("product", product)
		product_panel_instance.update_button(collector)

		owner.bought_product.connect(product_panel_instance.update_button.bind(collector))
		collector.collected.connect(product_panel_instance.update_button.bind(collector))
		product_panel_instance.pressed.connect(_on_buy.bind(product_panel_instance, product))
		product.sold_out.connect(_on_sold_out.bind(product_panel_instance, product))

		add_child(product_panel_instance)


func _on_buy(_panel: Button, product):
	var result: bool = owner.buy_product(product)


func _on_sold_out(button: Button, product):
	button.disabled = true
	button.pressed.disconnect(_on_buy)
