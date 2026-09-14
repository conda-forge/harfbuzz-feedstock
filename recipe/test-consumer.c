#include <hb.h>
#include <hb-ot.h>
#include <stdio.h>

int main(int argc, char **argv)
{
    if (argc != 2)
        return 1;
    hb_blob_t *blob = hb_blob_create_from_file_or_fail(argv[1]);
    if (!blob)
        return 2;
    hb_face_t *face = hb_face_create(blob, 0);
    hb_font_t *font = hb_font_create(face);
    hb_ot_font_set_funcs(font);
    hb_buffer_t *buffer = hb_buffer_create();
    hb_buffer_add_utf8(buffer, "abc", -1, 0, -1);
    hb_buffer_guess_segment_properties(buffer);
    hb_shape(font, buffer, NULL, 0);
    unsigned count = 0;
    hb_glyph_info_t *glyphs = hb_buffer_get_glyph_infos(buffer, &count);
    hb_glyph_position_t *positions = hb_buffer_get_glyph_positions(buffer, NULL);
    if (count != 3)
        return 3;
    for (unsigned i = 0; i < count; ++i)
        if (glyphs[i].codepoint == 0 || positions[i].x_advance <= 0)
            return 4;
    hb_buffer_destroy(buffer);
    hb_font_destroy(font);
    hb_face_destroy(face);
    hb_blob_destroy(blob);
    puts("PASS: installed HarfBuzz C API shapes font glyphs with positive advances");
    return 0;
}
