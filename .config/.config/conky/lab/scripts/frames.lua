------------------------------
--- Рамка вокруг блока CPU ---
------------------------------
function cpu_frame()
    cairo_move_to (cr, 15, 420)
    cairo_line_to (cr, 5, 420)
    cairo_line_to (cr, 5, 535)
    cairo_line_to (cr, 395, 535)
    cairo_line_to (cr, 395, 420)
    cairo_line_to (cr, 60, 420)

    cairo_set_line_width (cr, 2)
    cairo_set_source_rgba (cr, 0, 0.5, 0, 1)
    cairo_stroke (cr)
end

------------------------------
--- Рамка вокруг блока MEM ---
------------------------------
function mem_frame()
    cairo_move_to (cr, 15, 560)
    cairo_line_to (cr, 5, 560)
    cairo_line_to (cr, 5, 675)
    cairo_line_to (cr, 395, 675)
    cairo_line_to (cr, 395, 560)
    cairo_line_to (cr, 65, 560)

    cairo_set_line_width (cr, 2)
    cairo_set_source_rgba (cr, 0, 0.48627450980392, 0.59607843137255, 1)
    cairo_stroke (cr)
end
