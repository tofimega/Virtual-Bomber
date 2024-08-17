class_name SettingsData
extends Resource


@export_enum("fractional", "integer") var scale_mode: String="integer"
@export_enum("linear","nearest") var filter: int=0
@export_range(1,10) var scale: float=2
