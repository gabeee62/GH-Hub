extends Resource
class_name TagData

enum Tags {MATERIAL, TRINKET, WEAPON, UTILITY, GADGET, HEAL}
enum Area {NATURE, TECHNOLOGICAL, MECHANICAL, INDUSTRIAL, RESIDENTIAL, ELECTRICAL, MEDICAL, COMMERCIAL, SECURITY, EXODUS}

@export var item_type: Array[Tags]
@export var found_in: Array[Area]
