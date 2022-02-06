extends Reference

class_name ScoreCalculator

class PixelCount:
	var same: int = 0
	var main_colored: int = 0
	var ref_colored: int = 0

###### Public Methods ######
func calculate(main: TextureRect, ref: TextureRect):
	var main_image = main.get_texture().get_data()
	var ref_image = ref.get_texture().get_data()
	
	var pixel_count = _calculate_pixel_count(main_image, ref_image)
	var score = _calculate_score(pixel_count)
	
	print("score: " + str(score))
	GameEvents.emit_signal("score_calculated", score)
	
###### Private Methods ######
func _calculate_pixel_count(main_image: Image, ref_image: Image):
	var factor := 8
	
	var width := main_image.get_width() / factor
	var height := main_image.get_height() / factor
	
	main_image.resize(width, height)
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
	var same := float(pixel_count.same)
	var main := float(pixel_count.main_colored)
	var ref := float(pixel_count.ref_colored)
	
	var score := 0.0
	if(main != 0 && ref != 0):
		var main_to_ref = main / ref if ref > main else ref / main
		var same_to_main = same / main

		score = (same_to_main + main_to_ref) / 2 * 100
	
	return score
