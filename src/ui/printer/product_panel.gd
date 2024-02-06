extends Button


func update_button(collector: Collector):
	var product: Product = get_meta("product")
	disabled = product.quantity == 0 || product.cost > collector.stuff_collected
