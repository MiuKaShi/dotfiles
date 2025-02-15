------------------------------
--- Рамка вокруг блока CPU ---
------------------------------
function cpu_frame()
  cairo_move_to(cr, 15, 525)
  cairo_line_to(cr, 5, 525)
  cairo_line_to(cr, 5, 665)
  cairo_line_to(cr, 510, 665)
  cairo_line_to(cr, 510, 525)
  cairo_line_to(cr, 85, 525)

  cairo_set_line_width(cr, 2)
  cairo_set_source_rgba(cr, 0, 0.5, 0, 1)
  cairo_stroke(cr)
end

------------------------------
--- Рамка вокруг блока MEM ---
------------------------------
function mem_frame()
  cairo_move_to(cr, 15, 695)
  cairo_line_to(cr, 5, 695)
  cairo_line_to(cr, 5, 835)
  cairo_line_to(cr, 510, 835)
  cairo_line_to(cr, 510, 695)
  cairo_line_to(cr, 85, 695)

  cairo_set_line_width(cr, 2)
  cairo_set_source_rgba(cr, 0, 0.48627450980392, 0.59607843137255, 1)
  cairo_stroke(cr)
end
