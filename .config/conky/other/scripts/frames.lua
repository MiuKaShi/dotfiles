------------------------------
--- Рамка вокруг блока CPU ---
------------------------------
function cpu_frame()
    cairo_move_to (cr, 15, 360)
    cairo_line_to (cr, 5, 360)
    cairo_line_to (cr, 5, 460)
    cairo_line_to (cr, 355, 460)
    cairo_line_to (cr, 355, 360)
    cairo_line_to (cr, 60, 360)

    cairo_set_line_width (cr, 2)
    cairo_set_source_rgba (cr, 0, 0.5, 0, 1)
    cairo_stroke (cr)
end

------------------------------
--- Рамка вокруг блока MEM ---
------------------------------
function mem_frame()
    cairo_move_to (cr, 15, 480)
    cairo_line_to (cr, 5, 480)
    cairo_line_to (cr, 5, 575)
    cairo_line_to (cr, 355, 575)
    cairo_line_to (cr, 355, 480)
    cairo_line_to (cr, 65, 480)

    cairo_set_line_width (cr, 2)
    cairo_set_source_rgba (cr, 0, 0.48627450980392, 0.59607843137255, 1)
    cairo_stroke (cr)
end
