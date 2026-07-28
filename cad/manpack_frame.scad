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
part = "assembly"; // [assembly, exploded, side_panel, crossbeam_top_front, crossbeam_top_back, crossbeam_bottom_front, crossbeam_bottom_back, handle, antenna_mount_bnc, antenna_mount_so239, base_plate, battery_box]

// which connector variant the assembly views fit
ant_style = "bnc"; // [bnc, so239]

// lightening / ventilation windows in the side panels
panel_windows = true;

// draw a radio proxy block in the assembly views
show_radio = true;

// draw the bolt-on battery frame in the assembly views
show_battery_box = true;

// -----------------------------------------------------------------------------
//  RADIO
// -----------------------------------------------------------------------------
//  Both radios share the 124 mm width the frame is built around; they differ in
//  the depth that becomes the standing height, which is why the frame carries two
//  sets of mount holes.
//
//      Retevis RT-95    124 x 163 x 39 mm   -> 163 mm standing
//      AnyTone AT-779UV 124 x 101 x 36 mm   -> 101 mm standing
//
radio_w = 124.25;  // X  [PORTED] clear span measured between the reference rails

rt95_d   = 163;    // Z  standing height
rt95_h   = 39;     // Y  body thickness
at779_d  = 101;    // Z  standing height
at779_h  = 36;     // Y  body thickness

// which radio the assembly views draw
radio = "at779uv"; // [at779uv, rt95]
radio_d = (radio == "rt95") ? rt95_d : at779_d;
radio_h = (radio == "rt95") ? rt95_h : at779_h;

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
//  ANTENNA MOUNT -- shared bracket, two connector variants
// -----------------------------------------------------------------------------
//  Chassis common to both variants.  Keeping the leg, ribs and bolt pattern
//  identical means a BNC and an SO-239 bracket are interchangeable on the same
//  crossbeam insert pattern.
ant_pad_t     = 3.75;  // [PORTED] pad thickness
ant_leg_t     = 8;     // bracket leg thickness (new: bolted joint)
ant_bracket_w = 35;    // bracket width in X
ant_rib_t     = 5;     // gusset rib thickness.  Was 8, which swallowed one whole
                       //   bolt column: at 8 mm the rib spanned the full pad
                       //   depth in front of the counterbore mouth, sealing both
                       //   holes into inaccessible internal voids.
ant_inset     = 6;     // bracket's outboard edge, inboard of the panel inner
                       //   face.  Buys the bolt pockets 4.65 mm of clearance
                       //   from the crossbeam's own end-insert pockets.
// Bolts sit in the open span BETWEEN the ribs, symmetric about the centre.
// That symmetry is what lets one part serve both sides of the frame.
ant_bolt_dx   = [ant_bracket_w / 2 - 7, ant_bracket_w / 2 + 7];  // 10.5, 24.5

// --- variant A: BNC bulkhead (the reference connector) ---
bnc_bore_d  = 12.468;  // [PORTED]
bnc_reach   = 25;      // [PORTED] cantilever forward of the frame front face
bnc_setback = 12.66;   // [PORTED] bore centre, back from the pad's front tip

// --- variant B: SO-239 / UHF female, 4-hole square flange ---
//  0.625" panel cutout, four 0.138" holes on a 0.708" square (= 0.500" radius).
//  VERIFY against your own connectors before printing: flange patterns vary a
//  little between manufacturers.
so239_bore_d      = 15.88;  // 0.625"
so239_flange_p    = 17.98;  // 0.708" square pattern pitch
so239_flange_hole = 3.4;    // clearance for M3 / #4-40
so239_reach       = 30;     // longer than BNC so the flange screws clear the leg
so239_setback     = 17;     // bore centre, back from the pad's front tip

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

// Radio side bolts.  Y is the bay centre for both radios, exactly as the
// reference.  In Z there are TWO positions:
//
//   RT-95     Z 98  -- the ported reference position, bay centre.  A 163 mm
//                      radio hung here spans Z 16.5..179.5, filling the frame.
//   AT-779UV  Z 129 -- 31 mm higher, i.e. (163-101)/2, which puts the shorter
//                      radio's control face at the same 179.5 the RT-95 reaches.
//                      At the RT-95 hole the AT-779UV sat 31 mm too low.
//
// Both hole sets are cut in every panel; use whichever pair suits the radio.
radio_by      = frame_d / 2;                        // 35
radio_bz_rt95 = (z_bb1 + z_tb0) / 2;                // 98
radio_bz_at779= radio_bz_rt95 + (rt95_d - at779_d) / 2;  // 129
radio_bz_all  = [radio_bz_rt95, radio_bz_at779];
radio_bz = (radio == "rt95") ? radio_bz_rt95 : radio_bz_at779;
radio_z0 = radio_bz - radio_d / 2;
radio_z1 = radio_bz + radio_d / 2;

// handle
handle_z0 = z_tb1 - handle_lap;               // 132
handle_bz = [handle_z0 + 8, handle_z0 + 20];  // 140, 152
grip_y0   = (frame_d - grip_ap_len) / 2;      // 18.125
grip_y1   = grip_y0 + grip_ap_len;            // 51.875
handle_z1 = z_tb1 + grip_ap_h;                // 198.5
handle_z2 = handle_z1 + grip_bar_h;           // 210

// antenna brackets: inset from each panel's inner face, both unmirrored
ant_x_l     = panel_t + ant_inset;                              // 15
ant_x_r     = frame_w - panel_t - ant_inset - ant_bracket_w;    // 92.25
ant_bolt_z  = [z_tb0 + 6, z_tb0 + 16];                          // 162, 172
ant_bolt_gx = [for (bx = [ant_x_l, ant_x_r], dx = ant_bolt_dx) bx + dx];

// bottom interface plate
base_bolt_x = [35, frame_w - 35];             // 35, 107.25
base_bolt_y = [beam_cy_f, beam_cy_b];         // 8, 62
foot_x      = [14, frame_w - 14];             // 14, 128.25
foot_y      = [12, frame_d - 12];             // 12, 58

// Base-plate central opening.  The plate is a ring: all that remains is the
// perimeter backing the two side panels (X 0..9 and 133.25..142.25) and the two
// bottom crossbeams, widened front and back to carry the feet.
//
// It cannot follow the beam lines exactly.  The Ø16 feet at Y 12 / 58 reach 4 mm
// past them, and corner rounding cannot rescue it: at Y 16..54 the largest
// radius that fits (19) is still short of the 19.2 needed to clear a foot.
// Counter-intuitively a LARGER radius helps -- a small corner brings the opening
// nearer the foot -- so the optimum is the limit case, a full stadium.
//
// This also supersedes the old 36 x 26 cable slot: the opening spans the same
// 30 mm of Y and the entire width, so it passes anything the slot did.
// Inset 2 mm from the panel inner faces rather than tangent to them.  Tangent
// left exactly zero margin at the arc's leftmost point, and because the plate
// prints upside down that face is the first layer, where elephant-foot
// compensation enlarges a hole -- which would have let the opening creep ~0.2 mm
// under the panel edge.  Costs ~120 mm2 of opening, 3%.
base_open_inset = 2;
base_open_x0 = panel_t + base_open_inset;                 // 11
base_open_x1 = frame_w - panel_t - base_open_inset;       // 131.25
base_open_y0 = 20;
base_open_y1 = frame_d - base_open_y0;                    // 50
base_open_r  = (base_open_y1 - base_open_y0) / 2;         // 15 -> stadium ends
// material left between a foot boss and the opening edge
base_open_gap = sqrt(pow(base_open_x0 + base_open_r - foot_x[0], 2) +
                     pow(base_open_y0 + base_open_r - foot_y[0], 2))
                - base_open_r - foot_d / 2;

// panel windows: kept well clear of the M5 recess ligament and every counterbore
// Panel windows.  The upper one used to sit at Z 118..132, which the new
// AT-779UV recess (Z 115.8..142.2) runs straight through, so it moves above both
// recesses into the clear band between the recess top and the panel top.
win_a = [16, 44, 54, 74];    // y0 z0 y1 z1
win_b = [16, 150, 54, 172];

// =============================================================================
//  DERIVED-DIMENSION REPORT
//  Printed on every render so the fit assumptions stay visible.  radio_h and
//  radio_d are the two numbers to re-measure against the radio in hand: they
//  drive frame_d and bay_h respectively.
// =============================================================================
BED = 180;
echo(str("frame body            = ", frame_w, " x ", frame_d, " x ", z_tb1, " mm"));
echo(str("assembled envelope    = ", frame_w + 2 * handle_t, " x ",
         frame_d + ant_leg_t + max(bnc_reach, so239_reach), " x ",
         handle_z2, " mm  (depth shown for the deeper SO-239 bracket)"));
echo(str("radio bay (WxDxH)     = ", radio_w, " x ", frame_d - 2 * beam_d,
         " x ", bay_h, " mm"));
echo(str("radio clearance  side = ", (frame_d - 2 * beam_d - radio_h) / 2,
         " mm/side   above/below = ", (bay_h - radio_d) / 2, " mm"));
echo(str("panel print footprint = ", panel_h, " x ", frame_d,
         "  (bed ", BED, ") -> margin ", BED - panel_h, " mm"));
echo(str("panel under M5 recess = ", panel_t - m5_recess_h,
         " mm of material carrying the radio"));
echo(str("base plate opening    = ", base_open_x1 - base_open_x0, " x ",
         base_open_y1 - base_open_y0, " mm stadium, leaving ", base_open_gap,
         " mm of material to each foot"));
assert(base_open_gap >= 1.5, "base plate opening cuts too close to the feet");
assert(panel_h <= BED && frame_d <= BED, "side panel exceeds the print bed");
assert(radio_w <= BED, "crossbeam span exceeds the print bed");
// The radio is NOT limited by bay_h: the crossbeams sit at the extreme front and
// back in Y, so a radio in the Y 17..53 channel passes between them and may use
// the full panel height.  What it must clear is the beams in Y, and the base
// plate / panel top in Z.
// Warning, not an assert: the frame is already built, and whether a 1 mm
// interference is acceptable is the builder's call, not the model's.
if (frame_d - 2 * beam_d < radio_h)
    echo(str("WARNING: a ", radio_h, " mm radio does not fit the ",
             frame_d - 2 * beam_d, " mm clear channel between the crossbeams -- ",
             "short by ", radio_h - (frame_d - 2 * beam_d),
             " mm. Fix is beam_d ", beam_d, " -> ", beam_d - 1,
             ", which means reprinting all four crossbeams."));
assert(radio_z0 >= z_frame && radio_z1 <= z_tb1,
       "radio does not fit between the base plate and the panel top");
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

// Through-windows: rounded in their own plane, STRAIGHT through the thickness.
// (rbox rounds all twelve edges, which closes the cut over its through direction
// and leaves a full-width bridging lip -- fine for solids, wrong for windows.)
module win_thruZ(x0, y0, z0, dx, dy, dz, r = 3) {
    hull() for (x = [x0+r, x0+dx-r], y = [y0+r, y0+dy-r])
        translate([x, y, z0]) cylinder(r = r, h = dz);
}
module win_thruX(x0, y0, z0, dx, dy, dz, r = 3) {
    hull() for (y = [y0+r, y0+dy-r], z = [z0+r, z0+dz-r])
        translate([x0, y, z]) rotate([0, 90, 0]) cylinder(r = r, h = dx);
}
module win_thruY(x0, y0, z0, dx, dy, dz, r = 3) {
    hull() for (x = [x0+r, x0+dx-r], z = [z0+r, z0+dz-r])
        translate([x, y0, z]) rotate([-90, 0, 0]) cylinder(r = r, h = dy);
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
        // Two sets, one per radio.  Lower = RT-95 (the ported position), upper =
        // AT-779UV, 31 mm higher so the shorter radio's face reaches the same
        // height.  Recess edges end up 4.5 mm apart; the material between them is
        // full 9 mm thickness, only the discs themselves are thinned to 3.5 mm.
        for (bz = radio_bz_all) {
            translate([-1, radio_by, bz]) rotate([0, 90, 0])
                cylinder(d = m5_clear, h = panel_t + 2);
            translate([-0.01, radio_by, bz]) rotate([0, 90, 0])
                cylinder(d = m5_recess_d, h = m5_recess_h + 0.01);
        }

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
module antenna_mount(bore_d, reach, setback, flange_p = 0, flange_d = 0) {
    pad_z0 = beam_h - ant_pad_t;        // 20.25
    tip_y  = -(ant_leg_t + reach);
    bore_y = tip_y + setback;
    bore_x = ant_bracket_w / 2;         // 17.5, centred between the ribs
    difference() {
        union() {
            // leg against the crossbeam's front face
            translate([0, -ant_leg_t, 0]) rbox(ant_bracket_w, ant_leg_t, beam_h);
            // horizontal pad
            translate([0, tip_y, pad_z0])
                rbox(ant_bracket_w, ant_leg_t + reach, ant_pad_t);
            // [PORTED] diagonal gusset ribs, one on each edge.
            //
            // The profile deliberately runs the FULL height to beam_h rather than
            // stopping at the pad's underside. Stopping at pad_z0 left the rib
            // and the pad sharing nothing but a plane -- zero volumetric overlap
            // -- which printed as a visible seam along the top of every rib. The
            // extra material is entirely inside the pad, so the outer shape is
            // unchanged. The tail likewise runs back to Y=0 to interlock with
            // the leg.
            for (rx = [0, ant_bracket_w - ant_rib_t])
                translate([rx, 0, 0]) rotate([90, 0, 90])
                    linear_extrude(height = ant_rib_t)
                        polygon([[tip_y, pad_z0], [tip_y, beam_h], [0, beam_h],
                                 [0, 0], [-ant_leg_t, 0]]);
        }
        // connector bore
        translate([bore_x, bore_y, pad_z0 - 1])
            cylinder(d = bore_d, h = ant_pad_t + 2);
        // SO-239 only: four flange screw holes on a square pattern
        if (flange_p > 0)
            for (dx = [-flange_p/2, flange_p/2], dy = [-flange_p/2, flange_p/2])
                translate([bore_x + dx, bore_y + dy, pad_z0 - 1])
                    cylinder(d = flange_d, h = ant_pad_t + 2);
        // four M4 bolts into the crossbeam's front face, in the open span
        // between the ribs so every counterbore mouth is reachable
        for (dx = ant_bolt_dx, z = ant_bolt_z)
            translate([dx, -ant_leg_t, z - z_tb0])
                rotate([-90, 0, 0]) m4_bolt_hole(ant_leg_t);
    }
}

module antenna_mount_bnc() {
    antenna_mount(bnc_bore_d, bnc_reach, bnc_setback);
}

module antenna_mount_so239() {
    antenna_mount(so239_bore_d, so239_reach, so239_setback,
                  so239_flange_p, so239_flange_hole);
}

// the variant drawn in the assembly views
module antenna_mount_fitted() {
    if (ant_style == "so239") antenna_mount_so239(); else antenna_mount_bnc();
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
            // NB: this plate deliberately has NO raised locating lips on its top
            // face.  An earlier revision had two, and they made the part
            // unprintable: with the plate inverted (the only pose in which the
            // feet and every insert mouth face upward) the lips became the first
            // layers and 98% of the plate was left printing in mid-air above
            // them.  The side panels are located by their 16 bolts into the
            // crossbeams, so the lips were redundant anyway.
        }
        // bolts up into the bottom crossbeams (heads flush in the underside)
        for (x = base_bolt_x, y = base_bolt_y)
            translate([x, y, foot_h]) m4_bolt_hole(base_t);
        // future-module inserts, opening downward through the feet
        for (x = foot_x, y = foot_y)
            translate([x, y, 0]) m4_insert();
        // central opening -- also the battery lead's pass-through
        hull() for (x = [base_open_x0 + base_open_r, base_open_x1 - base_open_r],
                    y = [base_open_y0 + base_open_r, base_open_y1 - base_open_r])
            translate([x, y, foot_h - 1]) cylinder(r = base_open_r, h = base_t + 2);
    }
}

// =============================================================================
//  PART 10 -- battery_box
// -----------------------------------------------------------------------------
//  Open-face strap cradle for a TalentCell LF4011 12 V 6 Ah LiFePO4 pack. Bolts
//  up into the four M4 inserts in the base plate's feet -- the module interface
//  that was designed in from the start, so nothing on the frame changes.
//
//  Three walls plus a floor; the front face (-Y) is open so the pack slides in,
//  and the top is closed by the base plate itself. A hook-and-loop strap through
//  the four side slots crosses the open face and retains the pack.
//
//  >>> batt_x / batt_y / batt_z ARE PROVISIONAL <<<
//  Published TalentCell figures (90 x 70 x 105 mm, 730 g) are almost certainly
//  the retail carton -- a four-cell 32700 LiFePO4 pack weighing 730 g is much
//  smaller than that. MEASURE THE PACK and set these three numbers before
//  printing. Everything else follows from them. The strap-retained open face
//  makes the cradle forgiving of a pack that measures under, but not over.
// =============================================================================
//  The pack lies FLAT on its largest face.  Measured, not published:
batt_x = 132;    // along frame X
batt_y = 75.8;   // along frame Y
batt_z = 37.3;   // along frame Z  (lying flat)

box_wall   = 4;      // end and back wall thickness
box_floor  = 4;      // floor thickness
box_boss   = 8;      // top flange thickness; 8 keeps the joint on M4 x 12
box_clear  = 1.5;    // clearance around the pack
strap_zone = 13.5;   // clear space in front of the pack for the retaining strap
flange_w   = 19.5;   // how far the top flange reaches inboard from each end wall
strap_w    = 27;     // strap slot height (25 mm strap)
strap_t    = 4.5;    // strap slot thickness
win_inset  = 12;     // material left around each frame window

// derived
bb_cav_x = batt_x + 2 * box_clear;               // 135
bb_cav_y = batt_y + box_clear + strap_zone;      // 90.8
bb_cav_z = batt_z + box_clear;                   // 38.8
bb_out_x = bb_cav_x + 2 * box_wall;              // 143
bb_out_y = bb_cav_y + box_wall;                  // 94.8
bb_out_z = box_boss + 1 + bb_cav_z + box_floor;  // 51.8
bb_x0    = frame_w / 2 - bb_out_x / 2;           // -0.375, centred on the frame
bb_y0    = frame_d - bb_out_y;                   // -24.8, back flush with the frame
bb_z0    = -bb_out_z;                            // -51.8, underside of the floor
bb_cz1   = -(box_boss + 1);                      // -9,    cavity ceiling
bb_cz0   = bb_cz1 - bb_cav_z;                    // -47.8, cavity floor
bb_bat_y1= bb_y0 + bb_out_y - box_wall;          // 66, pack seats against the back
bb_bat_y0= bb_bat_y1 - batt_y;                   // -9.8, pack's front face
bb_tot_z = bb_out_z + foot_h;                    // 59.8, including the feet
// Side strips of floor left solid to carry the stacking feet, and the clear
// band between the two foot zones where a window can still go.
bb_pad_x = [[bb_x0, 26], [116.25, bb_x0 + bb_out_x]];

module battery_box() {
    difference() {
        union() {
            // two end walls, back wall and floor -- an open frame, not a box
            for (wx = [bb_x0, bb_x0 + bb_out_x - box_wall])
                translate([wx, bb_y0, bb_z0]) rbox(box_wall, bb_out_y, bb_out_z, 1.5);
            translate([bb_x0, bb_bat_y1, bb_z0])
                rbox(bb_out_x, box_wall, bb_out_z, 1.5);
            translate([bb_x0, bb_y0, bb_z0]) rbox(bb_out_x, bb_out_y, box_floor, 1.5);
            // Top flange along the full length of each end wall.  It overlaps the
            // pack's long edges by 18 mm and is what holds it down, and it carries
            // the four M4 bolts.  It runs the whole length rather than being four
            // pads because the bolts sit 10.4 mm inboard of the walls -- too far
            // to cantilever, and a full-width cross rail would be a 135 mm bridge.
            for (fx = [bb_x0, bb_x0 + bb_out_x - box_wall - flange_w])
                translate([fx, bb_y0, -box_boss])
                    rbox(box_wall + flange_w, bb_out_y, box_boss, 1.5);
            // Stacking interface: the same four feet the base plate presents, at
            // the same X/Y, so a further module bolts under this one exactly as
            // this one bolts under the base plate.
            //
            // Deliberately plain cylinders. A 45 degree print ramp would have to
            // run toward +Y (the downward direction in the print pose), and for
            // the rear pair at Y 58 that would reach Y 74 -- past the back face,
            // breaking both the "nothing behind the frame" rule and the print
            // pose's bed datum. Unramped they cost ~18 mm2 of unsupported area
            // each, which is what any horizontal boss costs.
            for (x = foot_x, y = foot_y)
                translate([x, y, bb_z0 - foot_h]) cylinder(d = foot_d, h = foot_h + 1);
        }
        // four M4 bolts up into the base plate's foot inserts
        for (x = foot_x, y = foot_y)
            translate([x, y, -box_boss]) m4_bolt_hole(box_boss);
        // Floor windows.  Reshaped around the stacking feet: a pair of central
        // windows either side of a centre rib, plus one small window in each
        // side strip in the clear band between that strip's two foot pads.
        for (sx = [28, frame_w/2 + 6])
            win_thruZ(sx, bb_y0 + 6, bb_z0 - 1,
                      37.1, bb_out_y - 18, box_floor + 2);
        for (sx = [5, 119.25])
            win_thruZ(sx, 27, bb_z0 - 1, 18, 16, box_floor + 2);
        // end wall windows, kept below the top flange
        for (wx = [bb_x0 - 1, bb_x0 + bb_out_x - box_wall - 1])
            win_thruX(wx, bb_y0 + win_inset + strap_zone, bb_z0 + win_inset,
                      box_wall + 2, bb_out_y - 2*win_inset - strap_zone,
                      bb_out_z - box_boss - 2*win_inset);
        // back wall window
        win_thruY(bb_x0 + win_inset, bb_bat_y1 - 1, bb_z0 + win_inset,
                  bb_out_x - 2*win_inset, box_wall + 2,
                  bb_out_z - box_boss - 2*win_inset);
        // Pack cavity: open at the front (-Y). It stops at the cavity ceiling and
        // must NOT run up into the flange zone -- the flanges reach inboard over
        // the pack on purpose and are the hold-downs. The top is still open
        // between them, because nothing is ever built there.
        translate([bb_x0 + box_wall, bb_y0 - 1, bb_cz0])
            rbox(bb_cav_x, bb_cav_y + 1, bb_cav_z, 1.5);
        // next-module inserts, opening downward through the feet
        for (x = foot_x, y = foot_y)
            translate([x, y, bb_z0 - foot_h]) m4_insert();
        // strap slots through both end walls, in the clear zone ahead of the pack
        for (wx = [bb_x0 - 1, bb_x0 + bb_out_x - box_wall - 1])
            translate([wx, bb_y0 + strap_zone/2 - strap_t/2,
                       bb_cz0 + bb_cav_z/2 - strap_w/2])
                rbox(box_wall + 2, strap_t, strap_w, 1.2);
    }
}

echo(str("battery frame outer   = ", bb_out_x, " x ", bb_out_y, " x ", bb_tot_z,
         " mm (", bb_out_z, " to the floor + ", foot_h, " of stacking feet), ",
         "reaching ", -bb_y0, " mm forward of the frame, nothing behind it"));
echo(str("module stack pitch    = ", bb_tot_z, " mm"));
echo(str("battery cavity        = ", bb_cav_x, " x ", bb_cav_y, " x ", bb_cav_z,
         " mm  for a ", batt_x, " x ", batt_y, " x ", batt_z, " mm pack lying flat"));
assert(bb_out_x <= BED && bb_tot_z <= BED && bb_out_y <= BED,
       "battery frame does not fit the print bed in its print pose");
assert(bb_cav_x >= batt_x && bb_cav_z >= batt_z, "cavity smaller than the pack");

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

    for (bx = [ant_x_l, ant_x_r])
        color("#5f9e6e") translate([bx, -ex, z_tb0]) antenna_mount_fitted();

    color("#8a8f98") translate([0, 0, -ex]) base_plate();
    if (show_battery_box)
        color("#6d7f96") translate([0, 0, -2 * ex]) battery_box();

    if (show_radio) radio_proxy();
}

// =============================================================================
//  OUTPUT  (each single-part case is laid out in its recommended print pose)
// =============================================================================
if      (part == "assembly") frame(0);
else if (part == "exploded") frame(26);

// flat on the bed, INNER face down: 164 x 70 x 9.  This way the Ø26.468 M5
// recess and the eight crossbeam counterbores all open upward as plain pockets.
// Outer-face-down would instead bridge a Ø26.5 ceiling directly under the
// 3.5 mm ligament that carries the radio's entire weight.
else if (part == "side_panel")
    translate([0, 0, panel_t]) rotate([0, 90, 0])
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

// On its back: every layer is smaller than the one below it, so the ribs and pad
// print with no supports and the bolt holes come out vertical.
//
// Each variant is a SINGLE symmetric part used twice -- print two of whichever
// connector you want. The earlier left/right split existed only because the bolt
// columns were offset (14/30) to dodge the crossbeam's end-insert pockets;
// insetting the whole bracket 6 mm instead lets the columns sit symmetrically
// between the ribs, which removes the handedness.
else if (part == "antenna_mount_bnc")   rotate([-90, 0, 0]) antenna_mount_bnc();
else if (part == "antenna_mount_so239") rotate([-90, 0, 0]) antenna_mount_so239();

// upside down: flat top face on the bed, feet upward, and every counterbore and
// insert mouth opening upward -- no supports, no bridges
else if (part == "base_plate")
    translate([0, frame_d, z_frame]) rotate([180, 0, 0]) base_plate();

// open face up: the cavity mouth becomes the top, so the floor is the bed
// face and nothing overhangs
// BACK WALL DOWN.  Floor-down would leave the two top flanges cantilevering
// 19.5 mm along the whole length of each end wall.  Stood on its back the
// flanges become vertical ribs growing off the back wall, supported the whole
// way, and the open front simply faces up.
else if (part == "battery_box")
    translate([-bb_x0, bb_tot_z, frame_d]) rotate([-90, 0, 0]) battery_box();
