////INPUTS
var m_wheel_up = mouse_wheel_up();
var m_wheel_down = mouse_wheel_down();
var m_x = device_mouse_x_to_gui(0);
var m_y = device_mouse_y_to_gui(0);
var right_analog_vertical = gamepad_axis_value(0, gp_axisrv);
var right_analog_horizontal = gamepad_axis_value(0, gp_axisrh);

////SCROLLING
var scroll_surface_total_y = scroll_height;
var scroll_surface_total_x = scroll_width;
//Height of the scrollable portion of the scrollbar
var scrollable_bar_height = (height / scroll_surface_total_y) * height;
var scrollable_bar_width = (width / scroll_surface_total_x) * width;
		
//MOUSE SCROLL
var change = (m_wheel_down - m_wheel_up);
if(change != 0) {
	//Note: you may want to alter how "fast" this changes to change the scroll speed
	scroll_ratio_y += change * (scrollable_bar_height / height);
	scroll_ratio_y = clamp(scroll_ratio_y, 0, 1);
}
// Right analog stick vertical scroll
if (abs(right_analog_vertical) >= 0.2){
	scroll_ratio_y += right_analog_vertical * (scrollable_bar_height / height);
	scroll_ratio_y = clamp(scroll_ratio_y, 0, 1);

}

// Right analog stick horizontal scroll
if (abs(right_analog_horizontal) >= 0.4){
	scroll_ratio_x += 0.1 * right_analog_horizontal * (scrollable_bar_width / width);
	scroll_ratio_x = clamp(scroll_ratio_x, 0, 1);

}


//The y offset all images drawn in the frame should add to their y draw position
scroll_offset_y = - scroll_ratio_y * (scroll_surface_total_y - height);

// The x offset of all text/images drawn
scroll_offset_x = - scroll_ratio_x * (scroll_surface_total_x - width);
		
//Scrollable bar 
scrollable_bar_y1 = (height - scrollable_bar_height) * scroll_ratio_y;
scrollable_bar_y2 = scrollable_bar_y1 + scrollable_bar_height;
		
//Hover
hover = point_in_rectangle(m_x - x, m_y - y, scroll_bar_x1, scrollable_bar_y1, scroll_bar_x2, scrollable_bar_y2);
		
//Dragging
if(mouse_check_button_pressed(mb_left)) {
	dragging = point_in_rectangle(m_x - x, m_y - y, scroll_bar_x1, scroll_bar_y1, scroll_bar_x2, scroll_bar_y2)	
} else if(mouse_check_button_released(mb_left)) {
	dragging = false;	
}
if(dragging) {
	var y_normalised = m_y - y - (scrollable_bar_height/2);
	scroll_ratio_y = y_normalised / (height - scrollable_bar_height);
	scroll_ratio_y = clamp(scroll_ratio_y, 0, 1);
}