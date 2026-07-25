// =============================================================================
//  Modular manpack internal frame -- Retevis RT-95 / AnyTone AT-779UV
// =============================================================================
//  Clean-room decomposition of RT95_Manpack_rails_Dual_antenna_mount_STL.stl
//  (one 140.75 x 85 x 228 mm part) into separately printable modules that all
//  fit a Prusa Mini 180 x 180 mm bed.
//
//  Every module-to-module joint: stainless M4 socket-cap bolt into a brass
//  heat-set insert.  The radio mounts on stainless M5 bolts.
//
//  Features carried over verbatim from the reference STL are tagged [PORTED].
//
//  Coordinate system (assembled frame):
//     X = width   0 = left panel outer face
//     Y = depth   0 = frame front face      (radio control panel faces up)
//     Z = height  0 = ground (underside of the feet)
// =============================================================================

$fa = 2;
$fs = 0.4;

/* [Output] */
part = "assembly"; // [assembly, exploded, side_panel, crossbeam_top_front, crossbeam_top_back, crossbeam_bottom_front, crossbeam_bottom_back, handle, antenna_mount, base_plate]

// lightening / ventilation windows in the side panels
panel_windows = true;

// draw a radio proxy block in the assembly views
show_radio = true;

// -----------------------------------------------------------------------------
//  RADIO
// -----------------------------------------------------------------------------
radio_w = 124.25;  // X  [PORTED] clear span measured between the reference rails
radio_h = 36;      // Y  body thickness
radio_d = 101;     // Z  body depth, standing on end

// -----------------------------------------------------------------------------
//  FRAME
// -----------------------------------------------------------------------------
panel_t  = 9.0;    // side panel thickness   (ref 8.25; +0.75 to seat M4 counterbores)
frame_d  = 70;     // frame depth in Y       (ref 60; +10 so the four-beam box
                   //                         clears the upward-facing control panel)
beam_d   = 16;     // crossbeam depth  (Y)
beam_h   = 24;     // crossbeam height (Z)
bay_h    = 116;    // clear Z between the bottom and top crossbeams
base_t   = 8;      // bottom interface plate thickness
foot_h   = 8;      // foot / module-boss height
foot_d   = 16;     // foot boss diameter
corner_r = 4;      // cosmetic corner radius

// -----------------------------------------------------------------------------
//  HARDWARE
// -----------------------------------------------------------------------------
m4_clear     = 4.4;    // M4 clearance hole
m4_cb_d      = 8.2;    // M4 socket-cap counterbore diameter
m4_cb_h      = 4.0;    // ... depth (head is 4.0 tall -> flush)
m4_ins_d     = 5.7;    // M4 heat-set insert pilot (6.0 mm OD, 8.0 mm long)
m4_ins_h     = 9.0;    // ... pocket depth (8.0 insert + 1.0 relief)
m4_ins_mouth = 6.6;    // ... lead-in chamfer diameter

m5_clear    = 5.000;   // [PORTED] reference hole is exactly 5.000
m5_recess_d = 26.468;  // [PORTED] outer-face knob / bolt-head recess
m5_recess_h = 5.5;     // [PORTED]

// -----------------------------------------------------------------------------
//  PORTED ANTENNA-EAR FEATURE
// -----------------------------------------------------------------------------
ant_hole_d       = 12.468; // [PORTED] antenna bulkhead hole
ant_pad_t        = 3.75;   // [PORTED] pad thickness
ant_reach        = 25;     // [PORTED] cantilever forward of the frame front face
ant_hole_setback = 12.66;  // [PORTED] hole centre, back from the pad's front tip
ant_rib_t        = 8;      // [PORTED] gusset rib thickness (ref rail plane = 8.25)
ant_leg_t        = 8;      // bracket leg thickness (new: bolted joint)
ant_bracket_w    = 35;     // bracket width in X
// In the reference the single gusset lives inside the 8.25 mm rail plane, which
// is what leaves the void under the antenna hole.  A bolt-on bracket has no rail
// to hide in, so the rib is duplicated onto BOTH edges of the bracket and the
// hole moves to the bracket centre, between them.
ant_hole_x       = ant_bracket_w / 2;   // 17.5, clear of both ribs

// -----------------------------------------------------------------------------
//  PORTED HANDLE FEATURE
// -----------------------------------------------------------------------------
grip_ap_len = 33.75; // [PORTED] hand aperture length (Y)
grip_ap_h   = 18.5;  // [PORTED] hand aperture height (Z)
grip_bar_h  = 11.5;  // [PORTED] grip bar section height
handle_t    = 12;    // handle thickness (ref 8.25; +3.75 to seat axial M4 inserts)
handle_lap  = 48;    // lap length onto the panel's outer face

// =============================================================================
//  DERIVED
// =============================================================================
frame_w = radio_w + 2 * panel_t;      // 142.25
z_frame = foot_h + base_t;            // 16   panel & beam bottoms
z_bb0   = z_frame;                    // 16   bottom beams
z_bb1   = z_bb0 + beam_h;             // 40
z_tb0   = z_bb1 + bay_h;              // 156  top beams
z_tb1   = z_tb0 + beam_h;             // 180  panel top
panel_h = z_tb1 - z_frame;            // 164

beam_y_f  = 0;
beam_y_b  = frame_d - beam_d;         // 54
beam_cy_f = beam_d / 2;               // 8
beam_cy_b = frame_d - beam_d / 2;     // 62

// beam-end bolts: two per end, stacked in Z so the joint cannot rotate
beam_dz = 5.5;
bb_z = [z_bb0 + beam_h/2 - beam_dz, z_bb0 + beam_h/2 + beam_dz]; // 22.5, 33.5
tb_z = [z_tb0 + beam_h/2 - beam_dz, z_tb0 + beam_h/2 + beam_dz]; // 162.5, 173.5

// radio side bolt: dead centre of the bay in Y and Z, exactly as the reference
radio_by = frame_d / 2;               // 35
radio_bz = (z_bb1 + z_tb0) / 2;       // 98
radio_z0 = radio_bz - radio_d / 2;    // 47.5
radio_z1 = radio_bz + radio_d / 2;    // 148.5

// handle
handle_z0 = z_tb1 - handle_lap;               // 132
handle_bz = [handle_z0 + 8, handle_z0 + 20];  // 140, 152
grip_y0   = (frame_d - grip_ap_len) / 2;      // 18.125
grip_y1   = grip_y0 + grip_ap_len;            // 51.875
handle_z1 = z_tb1 + grip_ap_h;                // 198.5
handle_z2 = handle_z1 + grip_bar_h;           // 210

// antenna brackets: outboard edge on a panel inner face, hole at the
// reference's 11.375 mm inboard offset.  Right-hand bracket is mirrored.
ant_x_l     = panel_t;                        // 9
ant_x_r     = frame_w - panel_t;              // 133.25 (mirror plane)
// Bolt columns must stay >=3 mm clear of the beam's own end-insert pockets
// (which occupy the first/last 9 mm of the span), hence 14 rather than 5.
ant_bolt_dx = [14, 30];                       // from the bracket's outboard edge
ant_bolt_z  = [z_tb0 + 6, z_tb0 + 16];        // 162, 172
ant_bolt_gx = [ant_x_l + ant_bolt_dx[0], ant_x_l + ant_bolt_dx[1],
               ant_x_r - ant_bolt_dx[1], ant_x_r - ant_bolt_dx[0]];

// bottom interface plate
base_bolt_x = [35, frame_w - 35];             // 35, 107.25
base_bolt_y = [beam_cy_f, beam_cy_b];         // 8, 62
foot_x      = [14, frame_w - 14];             // 14, 128.25
foot_y      = [12, frame_d - 12];             // 12, 58

// panel windows: kept well clear of the M5 recess ligament and every counterbore
win_a = [16, 44, 54, 74];   // y0 z0 y1 z1
win_b = [16, 118, 54, 132];

// =============================================================================
//  DERIVED-DIMENSION REPORT
//  Printed on every render so the fit assumptions stay visible.  radio_h and
//  radio_d are the two numbers to re-measure against the radio in hand: they
//  drive frame_d and bay_h respectively.
// =============================================================================
BED = 180;
echo(str("frame body            = ", frame_w, " x ", frame_d, " x ", z_tb1, " mm"));
echo(str("assembled envelope    = ", frame_w + 2 * handle_t, " x ",
         frame_d + ant_leg_t + ant_reach, " x ", handle_z2, " mm"));
echo(str("radio bay (WxDxH)     = ", radio_w, " x ", frame_d - 2 * beam_d,
         " x ", bay_h, " mm"));
echo(str("radio clearance  side = ", (frame_d - 2 * beam_d - radio_h) / 2,
         " mm/side   above/below = ", (bay_h - radio_d) / 2, " mm"));
echo(str("panel print footprint = ", panel_h, " x ", frame_d,
         "  (bed ", BED, ") -> margin ", BED - panel_h, " mm"));
echo(str("panel under M5 recess = ", panel_t - m5_recess_h,
         " mm of material carrying the radio"));
assert(panel_h <= BED && frame_d <= BED, "side panel exceeds the print bed");
assert(radio_w <= BED, "crossbeam span exceeds the print bed");
assert(frame_d - 2 * beam_d >= radio_h,
       "frame_d too small: the top crossbeams would overhang the control panel");
assert(bay_h >= radio_d, "bay_h too small for the radio's standing height");
assert(panel_t - m5_recess_h >= 3.0, "too little panel left under the M5 recess");
assert(m4_ins_h + m4_cb_h <= panel_t + beam_d, "M4 joint stack does not close");

// =============================================================================
//  HELPERS
// =============================================================================

// Rounded plate: thickness t along +X, dy x dz in the YZ plane.
module plate_x(t, dy, dz, r = corner_r) {
    hull() for (y = [r, dy - r], z = [r, dz - r])
        translate([0, y, z]) rotate([0, 90, 0]) cylinder(r = r, h = t);
}

// Rounded window cut through +X.
module window_x(t, w, r = 4) {
    hull() for (y = [w[0] + r, w[2] - r], z = [w[1] + r, w[3] - r])
        translate([0, y, z]) rotate([0, 90, 0]) cylinder(r = r, h = t);
}

// Box with every edge rounded.
module rbox(dx, dy, dz, r = 1.5) {
    hull() for (x = [r, dx - r], y = [r, dy - r], z = [r, dz - r])
        translate([x, y, z]) sphere(r = r);
}

// Heat-set insert pocket: mouth at local Z = 0, pocket running +Z.
module m4_insert() {
    cylinder(d = m4_ins_d, h = m4_ins_h + 0.01);
    cylinder(d1 = m4_ins_mouth, d2 = m4_ins_d, h = 1.2);
}

// M4 clearance hole with a flush counterbore: entered at local Z = 0, running
// +Z through material of thickness `thru`.
module m4_bolt_hole(thru) {
    translate([0, 0, -0.01]) cylinder(d = m4_cb_d, h = m4_cb_h + 0.01);
    translate([0, 0, -0.01]) cylinder(d = m4_clear, h = thru + 0.02);
}

// 2D profile rounded on both convex and concave corners.
module round2d(r) {
    offset(r = r) offset(r = -2 * r) offset(r = r) children();
}

// =============================================================================
//  PART 1 -- side_panel  (x2, identical; the right one is mirrored in place)
// -----------------------------------------------------------------------------
//  A flat plate carrying ONLY the ported radio mount plus through-holes for the
//  four crossbeams and the handle.  No feet, no handle, no antenna mount and no
//  heat-set inserts -- every insert lives in the mating part.
//  Local frame = assembly frame for the LEFT panel; outer face at X = 0.
// =============================================================================
module side_panel() {
    difference() {
        translate([0, 0, z_frame]) plate_x(panel_t, frame_d, panel_h);

        // --- [PORTED] radio mount: M5 through-hole + outer-face recess ---
        translate([-1, radio_by, radio_bz]) rotate([0, 90, 0])
            cylinder(d = m5_clear, h = panel_t + 2);
        translate([-0.01, radio_by, radio_bz]) rotate([0, 90, 0])
            cylinder(d = m5_recess_d, h = m5_recess_h + 0.01);

        // --- crossbeam bolts: heads recessed in the OUTER face ---
        for (y = [beam_cy_f, beam_cy_b], z = concat(bb_z, tb_z))
            translate([0, y, z]) rotate([0, 90, 0]) m4_bolt_hole(panel_t);

        // --- handle bolts: heads recessed in the INNER face ---
        for (y = [beam_cy_f, beam_cy_b], z = handle_bz)
            translate([panel_t, y, z]) rotate([0, -90, 0]) m4_bolt_hole(panel_t);

        // --- lightening / ventilation windows ---
        if (panel_windows) {
            translate([-1, 0, 0]) window_x(panel_t + 2, win_a);
            translate([-1, 0, 0]) window_x(panel_t + 2, win_b);
        }
    }
}

// =============================================================================
//  PART 2 -- crossbeam  (x4: front and back, top and bottom -> a closed box)
// -----------------------------------------------------------------------------
//  Mirrors the reference beams' role and placement (full 124.25 mm span between
//  the panel inner faces) with the section enlarged from the reference's
//  7 x 4 mm -- which cannot host an M4 insert -- to 16 x 24 mm.
//  Two axial M4 inserts per end: ALL inserts for the panel joint live here.
//  Local frame: X 0..radio_w along the span, Y 0..beam_d, Z 0..beam_h.
// =============================================================================
module crossbeam(antenna_face = false, base_face = false) {
    difference() {
        rbox(radio_w, beam_d, beam_h);

        // two inserts per end, axis along the span
        for (dz = [-beam_dz, beam_dz]) {
            translate([0, beam_d/2, beam_h/2 + dz])
                rotate([0, 90, 0]) m4_insert();
            translate([radio_w, beam_d/2, beam_h/2 + dz])
                rotate([0, -90, 0]) m4_insert();
        }

        // top-front beam: inserts in the FRONT face for the antenna brackets
        if (antenna_face)
            for (gx = ant_bolt_gx, z = ant_bolt_z)
                translate([gx - panel_t, 0, z - z_tb0])
                    rotate([-90, 0, 0]) m4_insert();

        // bottom beams: inserts in the UNDERSIDE for the bottom interface plate
        if (base_face)
            for (gx = base_bolt_x)
                translate([gx - panel_t, beam_d/2, 0]) m4_insert();
    }
}

// =============================================================================
//  PART 3 -- handle  (x2, one per side panel)
// -----------------------------------------------------------------------------
//  The reference's integral grip loop, ported: same 33.75 x 18.5 hand aperture
//  and 11.5 mm grip bar.  Now a separate inverted-U that laps the panel's outer
//  face on four M4 bolts (inserts in the handle legs, heads flush in the panel).
//  Local frame: mating face at X = 0, body running +X.
// =============================================================================
module handle() {
    difference() {
        translate([0, 0, handle_z0]) rotate([90, 0, 90])
            linear_extrude(height = handle_t)
                round2d(3) difference() {
                    square([frame_d, handle_z2 - handle_z0]);
                    translate([grip_y0, -1])
                        square([grip_ap_len, handle_z1 - handle_z0 + 1]);
                }
        // insert pockets, axis along X, opening onto the mating face
        for (y = [beam_cy_f, beam_cy_b], z = handle_bz)
            translate([0, y, z]) rotate([0, 90, 0]) m4_insert();
    }
}

// =============================================================================
//  PART 4 -- antenna_mount  (x2; the right-hand one is mirrored)
// -----------------------------------------------------------------------------
//  The reference's cantilevered antenna ear -- Ø12.468 hole, 3.75 mm pad, 25 mm
//  forward reach, diagonal gusset -- made modular.  Bolts to the FRONT FACE of
//  the top-front crossbeam on four M4 bolts.
//  Local frame: X 0..ant_bracket_w (0 = outboard edge), Y -(leg+reach)..0,
//               Z 0..beam_h (0 = the top-front beam's underside).
// =============================================================================
module antenna_mount() {
    pad_z0 = beam_h - ant_pad_t;          // 20.25
    tip_y  = -(ant_leg_t + ant_reach);    // -33
    hole_y = tip_y + ant_hole_setback;    // -20.34
    difference() {
        union() {
            // leg against the crossbeam's front face
            translate([0, -ant_leg_t, 0]) rbox(ant_bracket_w, ant_leg_t, beam_h);
            // horizontal pad
            translate([0, tip_y, pad_z0])
                rbox(ant_bracket_w, ant_leg_t + ant_reach, ant_pad_t);
            // [PORTED] diagonal gusset ribs, one on each edge, leaving the bore
            // under the antenna hole clear.  The tail runs back to Y=0 so each
            // rib interlocks with the leg's volume instead of merely touching it
            // on a coplanar face.
            for (rx = [0, ant_bracket_w - ant_rib_t])
                translate([rx, 0, 0]) rotate([90, 0, 90])
                    linear_extrude(height = ant_rib_t)
                        polygon([[tip_y, pad_z0], [0, pad_z0],
                                 [0, 0], [-ant_leg_t, 0]]);
        }
        // [PORTED] antenna bulkhead hole
        translate([ant_hole_x, hole_y, pad_z0 - 1])
            cylinder(d = ant_hole_d, h = ant_pad_t + 2);
        // four M4 bolts into the crossbeam's front face
        for (dx = ant_bolt_dx, z = ant_bolt_z)
            translate([dx, -ant_leg_t, z - z_tb0])
                rotate([-90, 0, 0]) m4_bolt_hole(ant_leg_t);
    }
}

// =============================================================================
//  PART 5 -- base_plate
// -----------------------------------------------------------------------------
//  The modular bottom interface.  Bolts up into the two bottom crossbeams on
//  four M4 bolts.  Its four bosses are simultaneously the frame's FEET and the
//  M4 attachment grid that future modules (battery, tuner, ...) bolt up into.
//  Local frame = assembly frame; Z 0 = ground.
// =============================================================================
module base_plate() {
    difference() {
        union() {
            translate([0, 0, foot_h]) rbox(frame_w, frame_d, base_t, 2);
            for (x = foot_x, y = foot_y)
                translate([x, y, 0]) cylinder(d = foot_d, h = foot_h + 1);
            // panel locating lips, between the crossbeams so nothing fouls.
            // Sunk 1 mm into the plate so they fuse rather than just touch.
            for (x = [panel_t, frame_w - panel_t - 2])
                translate([x, grip_y0, z_frame - 1]) rbox(2, grip_ap_len, 3, 0.8);
        }
        // bolts up into the bottom crossbeams (heads flush in the underside)
        for (x = base_bolt_x, y = base_bolt_y)
            translate([x, y, foot_h]) m4_bolt_hole(base_t);
        // future-module inserts, opening downward through the feet
        for (x = foot_x, y = foot_y)
            translate([x, y, 0]) m4_insert();
    }
}

// =============================================================================
//  ASSEMBLY
// =============================================================================
module radio_proxy() {
    color("#404048", 0.30)
        translate([panel_t, radio_by - radio_h/2, radio_z0])
            cube([radio_w, radio_h, radio_d]);
}

module frame(ex = 0) {
    color("#7f9dc0") translate([-ex, 0, 0]) side_panel();
    color("#7f9dc0") translate([frame_w + ex, 0, 0]) mirror([1, 0, 0]) side_panel();

    color("#c9a227") translate([panel_t, beam_y_f, z_bb0 - ex]) crossbeam(base_face = true);
    color("#c9a227") translate([panel_t, beam_y_b, z_bb0 - ex]) crossbeam(base_face = true);
    color("#c9a227") translate([panel_t, beam_y_f, z_tb0 + ex]) crossbeam(antenna_face = true);
    color("#c9a227") translate([panel_t, beam_y_b, z_tb0 + ex]) crossbeam();

    color("#b05a4a") translate([-ex, 0, 0]) mirror([1, 0, 0]) handle();
    color("#b05a4a") translate([frame_w + ex, 0, 0]) handle();

    color("#5f9e6e") translate([ant_x_l, -ex, z_tb0]) antenna_mount();
    color("#5f9e6e") translate([ant_x_r, -ex, z_tb0]) mirror([1, 0, 0]) antenna_mount();

    color("#8a8f98") translate([0, 0, -ex]) base_plate();

    if (show_radio) radio_proxy();
}

// =============================================================================
//  OUTPUT  (each single-part case is laid out in its recommended print pose)
// =============================================================================
if      (part == "assembly") frame(0);
else if (part == "exploded") frame(26);

// flat on the bed, outer face down: 164 x 70 x 9
else if (part == "side_panel")
    translate([panel_h, 0, 0]) rotate([0, -90, 0])
        translate([0, 0, -z_frame]) side_panel();

// long axis on the bed, 24 mm tall: end and front-face inserts are both in-plane
else if (part == "crossbeam_top_front")    crossbeam(antenna_face = true);
else if (part == "crossbeam_top_back")     crossbeam();
else if (part == "crossbeam_bottom_front") crossbeam(base_face = true);
else if (part == "crossbeam_bottom_back")  crossbeam(base_face = true);

// flat on the bed, 70 x 78 x 12; one bridge over the grip aperture
else if (part == "handle")
    translate([handle_z2 - handle_z0, 0, 0]) rotate([0, -90, 0])
        translate([0, 0, -handle_z0]) handle();

// on its back: every layer is smaller than the one below it, so the ribs and pad
// print with no supports; bolt holes come out vertical
else if (part == "antenna_mount") rotate([-90, 0, 0]) antenna_mount();

// upside down so the feet print upward with no supports
else if (part == "base_plate")
    translate([0, frame_d, z_frame + 2]) rotate([180, 0, 0]) base_plate();
