extends Reference

class_name ScoreCalculator

class PixelCount:
	var same: int = 0
	var main_colored: int = 0
	var ref_colored: int = 0

###### Properties ######
var _thread := Thread.new()

###### Public Methods ######
func calculate(main: TextureRect, ref: TextureRect):
	var main_image = main.get_texture().get_data()
	var ref_image = ref.get_texture().get_data()
	
	_thread.start(self, "_calculate", [main_image, ref_image])
	
func dispose():
	if _thread.is_active():
		_thread.wait_to_finish()

###### Private Methods ######
func _calculate_pixel_count(main_image: Image, ref_image: Image):
	var width = main_image.get_width()
	var height = main_image.get_height()
	
	ref_image.resize(width, height)
	
	var pixel_count = PixelCount.new()
	
	main_image.lock()
	ref_image.lock()
	for x in width:
		for y in height:
			var main_pixel = main_image.get_pixel(x, y)
			var ref_pixel = ref_image.get_pixel(x, y)
			
			if(main_pixel.a == 1):
				pixel_count.main_colored += 1

				if(main_pixel == ref_pixel):
					pixel_count.same += 1

			if(ref_pixel.a == 1):
				pixel_count.ref_colored += 1

	main_image.unlock()
	ref_image.unlock()
	
	return pixel_count

func _calculate_score(pixel_count: PixelCount) -> float:
	var same = pixel_count.same
	var main_colored = pixel_count.main_colored
	var ref_colored = pixel_count.ref_colored	
	
	var score := 0.0
	if(main_colored != 0 && ref_colored != 0):
		var diff = float(main_colored) / ref_colored \
			if(ref_colored > main_colored) \
			else float(ref_colored) / main_colored

		score = ((float(same) / main_colored) + diff) / 2 * 100
		
	return score

func _calculate(images):
	var main_image = images[0]
	var ref_image = images[1]

	var pixel_count = _calculate_pixel_count(main_image, ref_image)
	var score = _calculate_score(pixel_count)
	
	call_deferred("_publish_score")
	return score

# In theory this function should be called in a main thread
# This is because it is called in call_deferred
func _publish_score():
	var score = _thread.wait_to_finish()
	GameEvents.emit_signal("score_calculated", score)
