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
part = "assembly"; // [assembly, exploded, side_panel, crossbeam_top_front_dual, crossbeam_top_front_grid, crossbeam_top_back, crossbeam_bottom_front, crossbeam_bottom_front_rail, crossbeam_bottom_back, crossbeam_top_front_triple, compute_box_inline, compute_box_front, compute_box_front_cover, compute_box_front_populated, handle, handle_mic, antenna_mount_bnc, antenna_mount_so239, base_plate, battery_box]

// which top-front crossbeam the assembly is built with
top_front = "grid"; // [grid, triple, dual]

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
// -----------------------------------------------------------------------------
//  ACCESSORY RAIL -- top-front crossbeam's front face
// -----------------------------------------------------------------------------
//  Four equally spaced STATIONS across the front bar, each one a copy of the
//  antenna mount's own 4-bolt pattern -- two columns 14 mm apart, two rows 10 mm
//  apart.  So anything built to the antenna-mount footprint (mic hook, DC
//  charge-port holder, Le Frite compute box) bolts to any station, and the
//  antenna brackets themselves are unchanged.
grid_n       = 7;      // the grid layout's column count
grid_pitch   = 14;     // == the antenna mount's own bolt spacing, so EVERY
                       //   adjacent pair of columns is a valid station.  7 at
                       //   14 mm spans 84 mm and leaves 5.3 mm of material at
                       //   each beam end.
triple_pitch = 38;     // the triple layout's station pitch.  38 clears 35 mm
                       //   brackets by 3 mm, keeps 5.3 mm of material at the
                       //   beam ends, and puts stations 1 and 3 76 mm apart
rail_pitch   = 26;     // (unused; kept only as the note below)  26 was the quad
                       //   layout's station pitch before it became a grid:
                       //   it leaves 4.3 mm of material between the outermost
                       //   accessory pocket and the beam's own end-insert
                       //   pocket, and it puts antenna stations 1 and 4 78 mm
                       //   apart -- the original 77.25 mm spacing, recovered.
rail_bolt_dx = 7;      // half the within-station column spacing
dual_inset   = 6;      // dual layout: bracket's outboard edge, inboard of the
                       //   panel inner face

ant_pad_t     = 3.75;  // [PORTED] pad thickness
ant_leg_t     = 8;     // bracket leg thickness (new: bolted joint)
ant_bracket_w = 35;    // bracket width in X
ant_rib_t     = 5;     // gusset rib thickness.  Was 8, which swallowed one whole
                       //   bolt column: at 8 mm the rib spanned the full pad
                       //   depth in front of the counterbore mouth, sealing both
                       //   holes into inaccessible internal voids.
// Bolts sit in the open span BETWEEN the ribs, symmetric about the centre.
// That symmetry is what lets one part serve both sides of the frame.
ant_bolt_dx   = [ant_bracket_w/2 - rail_bolt_dx, ant_bracket_w/2 + rail_bolt_dx];

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
//  The reference grip was a squared-off loop: 33.75 x 18.5 aperture under an
//  11.5 mm bar, 30 mm proud of the frame. On the built pack that reads as two
//  blocky slabs -- hard on the bag it just fits into, and hard on the hand.
//  Reworked into an arch: 10 mm shorter overall, the shoulders tapered away
//  above the panel line, and every surface rounded except the face that mates to
//  the panel. The aperture is widened to keep roughly the same finger room after
//  losing height.
grip_ap_len = 40;    // hand aperture length (Y)   (ref 33.75)
grip_ap_h   = 13;    // hand aperture height (Z)   (ref 18.5)
grip_bar_h  = 7;     // grip bar section height    (ref 11.5)
handle_t    = 12;    // handle thickness (ref 8.25; +3.75 to seat axial M4 inserts)
handle_lap  = 48;    // lap length onto the panel's outer face
handle_fill = 2.5;   // 3D edge fillet on every face except the mating face

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
handle_z1 = z_tb1 + grip_ap_h;                // 193
handle_z2 = handle_z1 + grip_bar_h;           // 200

// --- microphone hanger, handle_mic variant only ---
//  A cross bar thrown across the U, low down, with a knob-type stud on its outer
//  face.  Low rather than high for two reasons: the arch is what the hand grips,
//  so the bar must stay out of it, and a mic hung at Z 146 rides down the flank
//  of the pack instead of swinging across the radio.  The bar is backed by the
//  side panel over its whole length, so it is in shear against the panel rather
//  than cantilevered.
//  The AT-779UV ships with its own bracket -- 55 H x 35 W x 10 D, two M3 holes
//  45 mm apart vertically -- so the handle does not have to capture the mic at
//  all.  It only has to present two flat, coplanar landings with an M3 insert in
//  each.  That is two cross beams rather than a plate, which is both less
//  filament and far more of the U left open than any keyhole allowed.
//
//  Trying to receive the knob directly was a dead end: a 20 mm disc needs a
//  pocket 29 mm tall, and the plate left in front of it came out 3.5 mm -- too
//  thin to trust, and it still only caught the disc by 1.9 mm because the neck
//  could never drop clear of the entry hole in a 61 mm opening.
//
//  Both landings sit on the outer face at X = handle_t, where the minkowski
//  leaves a genuinely flat region; the perimeter fillet curves away from it, so
//  the bracket seats on two coplanar strips and cannot rock.
//  The bracket has to sit ENTIRELY BELOW the grip aperture, or it spans the
//  opening and there is nowhere to put a hand.  55 mm of bracket will not fit
//  below a usable grip inside the original 61 mm U -- that leaves 6 mm -- so the
//  handle grows DOWNWARD onto the panel it already lies against.  It gains two
//  new cross beams below the original aperture, with an open window between them
//  so the extension is a frame rather than a slab.
mic_bracket   = [35, 55, 10];    // bracket W x H x D, for clash checks
mic_bolt_dz   = 45;              // M3 hole spacing, vertical -- MEASURED
mic_bolt_z    = [105, 105 + mic_bolt_dz];   // 105 / 150, insert centres
mic_beam_lo   = [99, 111];       // lower new beam; also the new handle base
mic_beam_hi   = [144, 156];      // upper new beam, directly under the grip
mic_win       = [111, 144];      // open window between them -- saves filament and
                                 //   leaves the mic lead somewhere to run
mic_grip_z0   = 156;             // grip aperture floor, raised off the old 132 so
                                 //   the bracket clears it.  Top still follows the
                                 //   arch, so the grip band is untouched at 7 mm.
mic_bar_ext   = 4;               // how far each beam runs into the legs to fuse
mic_fillet    = 3;               // concave fillet at each beam/leg joint: these
                                 //   are the joints that must not read as notches
mic_bolt_y    = frame_d / 2;     // 35, centred in the U

rail_z = [z_tb0 + 6, z_tb0 + 16];                               // 162, 172

// Two front-face layouts are kept.  Both use the SAME station pattern -- the
// antenna mount's four bolts -- they differ only in how many stations and where.
//
//   dual: 2 stations, one per antenna mount, at the reference bore spacing.
//         The original layout; leaves the beam's face otherwise bare.
//   quad: 4 equally spaced stations, a general accessory rail.
//
function stations(n, p) = [for (i = [0 : n-1]) frame_w/2 + (i - (n-1)/2) * p];
function station_bolts(sx) = [for (c = sx, d = [-rail_bolt_dx, rail_bolt_dx]) c + d];

dual_x    = [panel_t + dual_inset + ant_bracket_w/2,
             frame_w - panel_t - dual_inset - ant_bracket_w/2]; // 32.5, 109.75
triple_x  = stations(3, triple_pitch);                          // 33.125 .. 109.125
// The grid is defined by its COLUMNS, not by station centres: at a 14 mm pitch
// every adjacent pair already forms the antenna mount's bolt pattern, so the
// layout offers grid_n - 1 station positions instead of a fixed few.
grid_cols = stations(grid_n, grid_pitch);                       // 29.125 .. 113.125

// bolt columns each layout cuts into the beam's front face
dual_cols   = station_bolts(dual_x);
triple_cols = station_bolts(triple_x);
front_cols  = (top_front == "dual")   ? dual_cols
            : (top_front == "triple") ? triple_cols
            :                           grid_cols;

// antenna brackets: outermost stations of whichever layout.  On the grid that
// means the outermost adjacent column pairs.
grid_ant  = [(grid_cols[0] + grid_cols[1]) / 2,
             (grid_cols[grid_n-2] + grid_cols[grid_n-1]) / 2];  // 36.125, 106.125
station_x = (top_front == "dual")   ? dual_x
          : (top_front == "triple") ? triple_x
          :                           grid_ant;

// antenna brackets sit on the outermost two stations of whichever layout
ant_bolt_z  = rail_z;
ant_x_l     = station_x[0] - ant_bracket_w / 2;
ant_x_r     = station_x[len(station_x) - 1] - ant_bracket_w / 2;

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
echo(str("top-front layout      = ", top_front, ", ", len(front_cols),
         " bolt columns at X ", front_cols));
echo(str("                        ",
         (top_front == "grid")
             ? str(len(front_cols) - 1, " overlapping stations at ", grid_pitch, " mm")
             : str(len(front_cols) / 2, " fixed stations"),
         "; antenna bores ", station_x[len(station_x)-1] - station_x[0],
         " mm apart"));
// every layout's outermost pocket must clear the beam's own end-insert pockets
assert(min(dual_cols[0], triple_cols[0], grid_cols[0]) - m4_ins_d/2
           >= panel_t + m4_ins_h + 3 &&
       max(dual_cols[3], triple_cols[5], grid_cols[grid_n-1]) + m4_ins_d/2
           <= frame_w - panel_t - m4_ins_h - 3,
       "accessory columns foul the crossbeam's end inserts");
// the grid only works as a grid if its pitch IS the mount's bolt spacing
assert(grid_pitch == 2 * rail_bolt_dx,
       "grid pitch must equal the antenna mount's bolt spacing");
// the triple layout exists so three full-width brackets fit side by side
assert(triple_pitch > ant_bracket_w,
       "triple station pitch is narrower than the antenna bracket");
// antenna bolts must stay clear of the bracket's own gusset ribs
assert(ant_bolt_dx[0] - m4_cb_d/2 >= ant_rib_t &&
       ant_bolt_dx[1] + m4_cb_d/2 <= ant_bracket_w - ant_rib_t,
       "antenna bracket bolts overlap its gusset ribs");
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

// Box with every edge rounded.  The radius must not exceed half the smallest
// side: past that the sphere centres cross over and the hull comes out LARGER
// than the box asked for, silently.  That is how the compute box's 3 mm back
// wall became 5 mm thick.
module rbox(dx, dy, dz, r = 1.5) {
    assert(r <= min(dx, dy, dz) / 2 + 1e-9,
           str("rbox radius ", r, " exceeds half the smallest side of ",
               dx, " x ", dy, " x ", dz));
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
module crossbeam(front_cols = [], base_face = false) {
    difference() {
        rbox(radio_w, beam_d, beam_h);

        // two inserts per end, axis along the span
        for (dz = [-beam_dz, beam_dz]) {
            translate([0, beam_d/2, beam_h/2 + dz])
                rotate([0, 90, 0]) m4_insert();
            translate([radio_w, beam_d/2, beam_h/2 + dz])
                rotate([0, -90, 0]) m4_insert();
        }

        // top-front beam: accessory bolt columns in its FRONT face
        for (gx = front_cols, z = rail_z)
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
// Outer silhouette, in (u = Y, v = Z - handle_z0).  Straight-sided over the lap,
// then a half-ellipse arch springing from the panel line, so the shoulders taper
// instead of carrying the full 70 mm depth to a flat square top.
// `extend` drops the base further down, used when offsetting for the aperture.
module handle_outer(extend = 0) {
    lap_v = z_tb1 - handle_z0;                    // 48, panel top
    top_v = handle_z2 - handle_z0;                // 68, handle top
    union() {
        translate([0, -extend]) square([frame_d, lap_v + extend]);
        translate([frame_d/2, lap_v])
            scale([1, (top_v - lap_v) / (frame_d/2)])
                difference() {
                    circle(r = frame_d/2);
                    translate([-frame_d/2, -frame_d/2])
                        square([frame_d, frame_d/2]);
                }
    }
}

// The aperture's top is the OUTER arch offset inward by grip_bar_h, not a flat
// line.  A flat top under a curved arch necessarily pinches at the ends: it
// waisted the band to 5.29 mm at Y 21 and Y 49 against 7.00 mm at the apex -- a
// 24% notch sitting exactly where the arch meets the shoulder, which is the last
// place you want one.  Following the arch keeps the band constant instead, and it
// then widens naturally into the leg where the aperture's sides cut it off.
module handle_profile() {
    difference() {
        handle_outer();
        round2d(4) intersection() {
            translate([grip_y0, -40]) square([grip_ap_len, 400]);
            offset(r = -grip_bar_h) handle_outer(extend = 40);
        }
    }
}

// handle_profile() plus the cross bar.  The bar is unioned into the PROFILE, so
// it goes through the same minkowski and comes out with the same 2.5 mm edge
// round and the same flat mating face as the rest of the handle.
//
// offset(r=+f) then offset(r=-f) fills concave corners with radius f and leaves
// convex ones alone, which puts a real fillet where the bar lands on each leg.
// Butting a square bar into the leg would have left a sharp internal corner in
// exactly the place the last handle was criticised for -- a re-entrant corner at
// a load path is a notch whether it is cut or grown.
// Built from handle_outer() rather than by patching handle_profile(), because the
// grip aperture no longer runs out through the bottom edge -- it now has a floor.
module handle_profile_mic() {
    ext_v = mic_beam_lo[0] - handle_z0;          // -33, how far the body drops
    offset(r = -mic_fillet) offset(r = mic_fillet)
    difference() {
        union() {
            handle_outer();
            translate([0, ext_v]) square([frame_d, -ext_v]);
        }
        // grip aperture: floor raised to mic_grip_z0, top still the offset arch
        round2d(4) intersection() {
            translate([grip_y0, mic_grip_z0 - handle_z0])
                square([grip_ap_len, 400]);
            offset(r = -grip_bar_h) handle_outer(extend = 40);
        }
        // window between the two new beams
        round2d(4) translate([grip_y0, mic_win[0] - handle_z0])
            square([grip_ap_len, mic_win[1] - mic_win[0]]);
    }
}

// M3 heat-set pockets for the bracket, opening onto the OUTER face and running
// inward.  M3 here, M4 everywhere the handle meets the frame -- the two must not
// be confused at assembly, and they open on opposite faces, which helps.
module mic_bracket_inserts() {
    for (z = mic_bolt_z)
        translate([handle_t + 0.1, mic_bolt_y, z]) rotate([0, -90, 0]) {
            cylinder(d = m3_ins_d, h = m3_ins_h + 0.1);
            cylinder(d = m3_ins_d + 0.8, h = 1.0);      // lead-in at the mouth
        }
}

module handle(mic = false) {
    union() {
    difference() {
        translate([0, 0, handle_z0]) rotate([90, 0, 90])
            difference() {
                // Fillet every edge by handle_fill, then slice the result back at
                // the mating plane.  Extruding to handle_t - fill and shrinking the
                // profile by fill first means the sphere restores full size, so the
                // mating face comes out flat and full-width while the outer face
                // and the whole perimeter stay rounded.
                minkowski() {
                    linear_extrude(height = handle_t - handle_fill)
                        offset(r = -handle_fill)
                            if (mic) handle_profile_mic(); else handle_profile();
                    sphere(r = handle_fill, $fn = 16);
                }
                translate([-60, -60, -2 * handle_fill])
                    cube([250, 250, 2 * handle_fill]);
            }
        // insert pockets, axis along X, opening onto the mating face
        for (y = [beam_cy_f, beam_cy_b], z = handle_bz)
            translate([0, y, z]) rotate([0, 90, 0]) m4_insert();
        if (mic) mic_bracket_inserts();
    }
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
//  PART 12 -- compute_box, two variants
// -----------------------------------------------------------------------------
//  Carries a Libre Computer La Frite (64 x 55 mm, Raspberry Pi Model A mounting
//  pattern -- M3 on 58 x 49.5) plus a CM108/CM119 USB audio fob, a PTT board and
//  a GPS module, for onboard logging over WiFi to a tablet.
//
//  Only the SBC gets a dedicated mount, because it is the only one of the four
//  whose footprint is fixed and known.  Everything else lands on a generic M3
//  through-hole grid at 10 mm pitch plus zip-tie slots, so swapping a CM108 for
//  a CM119 -- or changing the PTT board entirely -- costs nothing here.  The grid
//  holes double as ventilation.
//
//    inline : sits in the module stack, above the battery box.  Bolts up into
//             the plate above and presents the same four feet below, so the
//             battery box hangs off it unchanged.  SBC lies flat.
//    front  : bolts to the top-front crossbeam's accessory columns and hangs
//             down the front of the frame.  At 50 mm deep the interior is 44 mm
//             and the board's smallest dimension is 55, so here the SBC stands
//             on the BACK wall with its ports facing forward, and the three
//             small boards layer in front of it.
// =============================================================================
sbc_l     = 64;      // La Frite board outline
sbc_w     = 56;      // measured; was 55 from the published figure
//  Mounting pattern.  M3 CONFIRMED by test-fitting a bolt in the board.
//  sbc_hx was the published Pi Model A figure of 58, and a PRINTED TEST FIT showed
//  it short: with the pair nearest the converter seated, the pair at the USB end
//  missed by 0.5-1 mm.  58.75 is the midpoint of that observed range.  This axis
//  runs UP Z in the fitted orientation, so it is the board's long 64 mm side.
//  If it is still tight, this is the one number to move.
sbc_hx    = 58.75;   // was 58 -- corrected against the printed part
sbc_hy    = 49.5;    //   across X; this pair fitted and is left alone
sbc_stand = 6;       // standoff height, was 5.  Raised with the pocket below so
                     //   the heat-set insert has somewhere to go.
sbc_ins_h = 6;       // M3 pocket depth in the standoff, was m3_ins_h = 5.  The
                     //   insert was bottoming out; +1 mm gives it room and still
                     //   leaves 1 mm of pad under it, plus 2 mm of back wall.
sbc_clear = 22;      // clear height above the standoff for connectors + eMMC
m3_ins_d  = 4.0;     // M3 heat-set insert pilot
m3_ins_h  = 5.0;
m3_clear  = 3.4;     // M3 clearance hole for the generic grid
cm_grid   = 10;      // generic mounting grid pitch
cm_wall   = 3;
cm_floor  = 4;
cm_port_h = 16;      // port cutout height
cm_tie    = [3, 12]; // zip-tie slot section

// --- inline variant ---
cmi_cav_z = sbc_stand + sbc_clear + 2;                   // 29, +2 so the
                     //   board clears the top flanges
cmi_z     = box_boss + cmi_cav_z + cm_floor + foot_h;    // 49, the stack pitch

// --- front variant ---
//  Usable envelope on the front of the frame is 160 H x 80 W x 50 D.  At that
//  size all four boards lie FLAT on the back wall (74 x 154 interior = 11396 mm2
//  against ~6684 mm2 of boards), so nothing has to layer and the depth is set
//  purely by the tallest component rather than by the budget: 5 mm standoff plus
//  ~22 mm of board and connectors plus slack = 30 interior.  17 mm of the depth
//  allowance goes unused, which is the point.
cmf_x     = 72;      // outer width -- 72 not 80, so ONE antenna mount still fits
                     //   beside it on the rail (9.5 mm gap).  Width is set by the
                     //   rail, not by the contents: the SBC needs 56 across and
                     //   the converter 65, both inside the 66 mm interior.
cmf_z     = 160;     // outer height
cmf_y     = 40;      // outer depth.  Was 33 -- only what the SBC needed -- but the
                     //   converter lies flat with its 35 mm dimension running
                     //   front-to-back, so interior depth had to reach 37.
                     //   Still inside the 50 mm envelope.
cmf_bolt  = 28;      // bolt column spacing = grid columns 5 and 7 (85.125 and
                     //   113.125), the pair that lands inside a 72 mm box sitting
                     //   right of an antenna mount
cmf_boss  = 8;       // local back-wall thickness at the bolts, so an M4 counter-
                     //   bore has material to seat in (3 mm wall alone does not)
// --- port cluster, measured off the board ---
//  44 wide along the board edge x 15 through the box depth, the 15 centred on the
//  top of the standoffs (= the board plane).  That depth reference proves the
//  connectors open in the PLANE of the board, so once the board is rotated they
//  face up and down inside the box and no wall needs a cutout for them.
//  The board is rotated 90 degrees from my first attempt: USB edge UP toward the
//  radio, power and Ethernet edge DOWN toward the battery.  So the 44 x 15 cluster
//  opens along Z inside the box, not through a side wall, and both downward ports
//  are connect-before-closing -- there is no insertion access once the cover is on.
//  Consequence: 49.5 of the hole pattern runs across X, 58 up Z.
//  The board sits 5 mm lower than it first did.  Dropping the buck flat onto the
//  floor (Z 3..17 instead of 8..22 on ribs) freed 5 mm, and spending it by moving
//  the board down rather than by widening the connector gap keeps that gap at
//  exactly 22 mm while handing the 5 mm to the USB bay, where it is scarce.
cmf_bay_buck  = [3, 18];     // bottom bay: buck converter, flat on the floor
cmf_bay_sbc   = [39, 103];   // the board itself, 64 tall in this orientation
cmf_bay_usb   = [107, 157];  // top bay: USB devices, plugged into the upward ports
// --- cover ---
// --- buck converter, MEASURED 35 H x 65 W x 15 D, wires off the 35 mm end ---
//  It lies flat on the floor: 65 across X, 35 front-to-back, 15 tall.  That is
//  the pose that costs the least height, which is what the connector gap above it
//  is short of.  65 is the OVERALL width including its mounting ears, and it goes
//  into the 66 mm interior as-is -- the box does not widen for it.  Depth is the
//  one dimension that had to give: 35 front-to-back needs 37 of interior.
cmf_buck     = [65, 35, 15];             // W x D(front-to-back) x H
cmf_buck_x   = [(cmf_x - 2*cm_wall - 65)/2 + cm_wall,
                (cmf_x - 2*cm_wall + 65)/2 + cm_wall];   // 3.5 .. 68.5
//  Mounting: the LY-KREE XS120503 has a slotted fork tab at each end, so two
//  fixings, not four.  MEASURED 54 mm apart and 13.5 mm in from the back.
//  The 65 mm overall is across the tabs, so the holes land 5.5 mm inboard of each
//  end -- which is consistent, and is why the datum below is read as the INSIDE
//  face of the back wall rather than the outside: the converter registers against
//  that face, and 13.5 from it falls inside the 35 mm footprint.
cmf_buck_dx  = 54;                       // hole spacing across the box
cmf_buck_by  = 13.5;                     // holes, back from the inside face
cmf_buck_bd  = m3_clear;                 // 3.4, M3 clearance -- plain through
                                         //   holes, screw from underneath.  The
                                         //   tabs are slotted, so they absorb the
                                         //   tolerance a round hole does not.
//  Power now enters through the BACK WALL rather than the floor -- the converter
//  is sitting where the floor hole used to be, and coming in at the back lets the
//  12 V leads turn once into the frame instead of doubling back under the module.
cmf_grom     = 12;   // grommeted power entry, now in the back wall
cmf_grom_x   = 12;   // Moved off centre into the FIRST QUARTER (X 0..18) to keep
                     //   the 12 V run away from the Ethernet and HDMI adapters,
                     //   which hang off the board's downward edge.  Left/right is
                     //   as seen looking INTO the opening with the M4 pads at top:
                     //   in that view low X is screen-left.  Ø12 at X 12 spans
                     //   6..18 -- inside the first quarter, 3 mm off the interior
                     //   wall at X 3.
cmf_grom_z   = 28;   // its centre.  HARD CONSTRAINT: the bottom-front crossbeam
                     //   occupies global Z 16..40 = box-local -4..20, so the back
                     //   wall is flat against beam material below box-local 20 and
                     //   a hole there would open into the beam, not the frame.
                     //   Ø12 at 28 spans 22..34: 2 mm clear of the beam, 5 mm
                     //   below the board edge at 39.
cmf_notch    = [cm_wall, cmf_x - cm_wall];  // the cover's locating rim runs unbroken
                     //   around the opening, projecting 2 mm in over Z 3..7.  With
                     //   a 35 mm converter in a 37 mm interior there is nothing to
                     //   give, so the bottom rim is now notched over its whole
                     //   width.  Three sides still locate the cover; six screws
                     //   hold it.
// --- power switch in the TOP wall ---
//  Ø12 barrel through a 20 x 32 bezel, long side running front-to-back along the
//  box depth.  The top wall is 72 x 40, and the rim slot used to sit at X 15..45 --
//  squarely where the bezel wants to go -- so the slot moved left to X 6..36 and
//  the switch took the right-hand end.  That gives 12 mm between them and 4 mm to
//  the outer edge, against 2 mm if the slot had stayed put.
cmf_sw_fp    = [20, 32];  // bezel footprint, W x D.  Not cut -- it is the keep-out
                          //   that positions the hole, and must clear the rim slot
                          //   and both box edges.
cmf_sw_d     = 12;        // panel hole for the barrel
cmf_sw_x     = 58;        // bezel spans X 48..68
cmf_sw_y     = -20;       // bezel spans Y -4..-36, centred in the depth
cmf_rim_x    = 6;         // top rim slot, moved left from 15 to clear the bezel
cmf_cov_t    = 3;    // cover panel thickness
cmf_cov_lip  = 2;    // locating lip that nests inside the opening
//  NO SCREWS.  The cover is held on with velcro tape -- lighter, and it removes
//  the six brass inserts and six M3 screws along with the bosses that carried
//  them.  Those bosses were the part of this box that never worked: their pockets
//  were cut at X 9 and 63 with the walls only at X 0..3 and 69..72, so for several
//  revisions the cover had six holes and nothing behind them.
//
//  The locating RIM now does all the alignment, which makes it load-bearing rather
//  than a nicety.  Note it is absent along the bottom edge -- notched full width so
//  the converter could sit flat -- so the cover is located on three sides only.
cmf_cov_z    = [];            // retained empty: no screw rows


// 4 x M3 bosses on the SBC pattern, standing sbc_stand tall from Z=0
// Sunk 1 mm into whatever they stand on: butting them at exactly Z=0 left the
// pads sharing only a plane with the floor, which printed the inline box as five
// separate shells.
module sbc_pads() {
    for (dx = [-sbc_hx/2, sbc_hx/2], dy = [-sbc_hy/2, sbc_hy/2])
        translate([dx, dy, -1]) cylinder(d = 8, h = sbc_stand + 1);
}
module sbc_pad_pockets() {
    for (dx = [-sbc_hx/2, sbc_hx/2], dy = [-sbc_hy/2, sbc_hy/2])
        translate([dx, dy, sbc_stand - sbc_ins_h])
            cylinder(d = m3_ins_d, h = sbc_ins_h + 0.1);
}
// generic M3 grid over a rectangle, as through-holes (nuts or nylon standoffs
// underneath) -- they also ventilate
module cm_grid_holes(x0, y0, x1, y1, t) {
    for (x = [x0 : cm_grid : x1], y = [y0 : cm_grid : y1])
        translate([x, y, -1]) cylinder(d = m3_clear, h = t + 2);
}

// Topology deliberately mirrors battery_box, which is the one shape already
// proven to print on this frame: back wall, two end walls, a floor, full-length
// top flanges carrying the M4s, feet below, and open at the FRONT and TOP.
// Floor-down would put the feet on the bed under a full-width floor -- the same
// mid-air failure the base plate had -- and a closed front would become a
// 142 x 49 ceiling in the back-down pose.  Open front doubles as the port
// access: the SBC sits with its connector edge facing out of it.
module compute_box_inline() {
    cz1 = -box_boss;                         // flange underside
    cz0 = cz1 - cmi_cav_z;                   // floor top
    fz  = cz0 - cm_floor;                    // floor underside
    fl  = 24;                                // flange reach inboard from each end
    // The SBC does NOT have to dodge the flanges: it tops out 1 mm below their
    // underside, so the whole floor width is usable.  Sit it against the left
    // wall and give the rest of the floor to the grid.
    sbc_cx = cm_wall + 6 + sbc_l/2;          // 41
    sbc_cy = frame_d/2;
    difference() {
        union() {
            // end walls and back wall
            for (wx = [0, frame_w - cm_wall])
                translate([wx, 0, fz]) rbox(cm_wall, frame_d, cmi_cav_z + cm_floor, 1.5);
            translate([0, frame_d - cm_wall, fz])
                rbox(frame_w, cm_wall, cmi_cav_z + cm_floor, 1.5);
            // floor
            translate([0, 0, fz]) rbox(frame_w, frame_d, cm_floor, 1.5);
            // top flanges along both end walls, carrying the four M4s.
            // Sunk 1 mm into the wall tops -- butting them at exactly cz1 left
            // each flange as its own shell.
            for (fx = [0, frame_w - fl])
                translate([fx, 0, cz1 - 1]) rbox(fl, frame_d, box_boss + 1, 1.5);
            // stacking feet, the same interface the base plate presents
            for (x = foot_x, y = foot_y)
                translate([x, y, fz - foot_h]) cylinder(d = foot_d, h = foot_h + 1);
            // SBC standoffs
            translate([sbc_cx, sbc_cy, cz0]) sbc_pads();
        }
        translate([sbc_cx, sbc_cy, cz0]) sbc_pad_pockets();
        // generic M3 grid over the rest of the floor
        translate([0, 0, fz])
            cm_grid_holes(sbc_cx + sbc_l/2 + 8, 12, frame_w - cm_wall - 6,
                          frame_d - 12, cm_floor);
        // M4 up into the plate above, and inserts down for the next module
        for (x = foot_x, y = foot_y) {
            translate([x, y, cz1]) m4_bolt_hole(box_boss);
            translate([x, y, fz - foot_h]) m4_insert();
        }
        // zip-tie slots through the floor beside the grid
        for (x = [sbc_cx + sbc_l/2 + 4, frame_w - cm_wall - 4], y = [16, frame_d - 16])
            translate([x, y, fz - 1]) rbox(cm_tie[0], cm_tie[1], cm_floor + 2, 1);
    }
}

module compute_box_front() {
    // local frame: X 0..cmf_x, Y -cmf_y..0 (0 = frame front face), Z 0..cmf_z
    // with Z 0 at the box bottom.  Fitted so its top sits at the crossbeam top.
    bz  = [cmf_z - 18, cmf_z - 8];          // bolt rows, = global Z 162 / 172
    bx  = [cmf_x/2 - cmf_bolt/2, cmf_x/2 + cmf_bolt/2];
    scz = (cmf_bay_sbc[0] + cmf_bay_sbc[1]) / 2;   // 76
    difference() {
        union() {
            translate([0, -cm_wall, 0]) rbox(cmf_x, cm_wall, cmf_z, 1.5);
            for (wx = [0, cmf_x - cm_wall])
                translate([wx, -cmf_y, 0]) rbox(cm_wall, cmf_y, cmf_z, 1.5);
            translate([0, -cmf_y, 0]) rbox(cmf_x, cmf_y, cm_wall, 1.5);
            translate([0, -cmf_y, cmf_z - cm_wall]) rbox(cmf_x, cmf_y, cm_wall, 1.5);
            // Local thickening so the M4 counterbores have something to seat in
            // -- a 3 mm wall cannot hold a 4 mm counterbore.  One pad per column
            // spanning both rows: separate pads per bolt overran the box top.
            for (x = bx)
                translate([x - 8.5, -cmf_boss, bz[0] - 8.5])
                    rbox(17, cmf_boss, bz[1] - bz[0] + 16, 1.5);
            // SBC standoffs.  The extra rotate([0,0,90]) is the 90 degree board
            // turn: it puts 49.5 of the pattern across X and 58 up Z, which is
            // what points the USB edge up and the power/Ethernet edge down.
            translate([cmf_x/2, -cm_wall, scz])
                rotate([90, 0, 0]) rotate([0, 0, 90]) sbc_pads();
        }
        translate([cmf_x/2, -cm_wall, scz])
            rotate([90, 0, 0]) rotate([0, 0, 90]) sbc_pad_pockets();
        // M4 into the crossbeam's accessory columns
        for (x = bx, z = bz)
            translate([x, -cmf_boss, z]) rotate([-90, 0, 0]) m4_bolt_hole(cmf_boss);
        // --- cable entries ---
        // Both are rim slots.  The back wall is deliberately solid: it faces the
        // crossbeam, so anything routed through it would have to turn immediately,
        // and the two rim slots already reach both ends of the box.
        // TOP RIM: audio, PTT and the GPS lead come off the radio's control face,
        // which points up at Z 179.5.  They pass over the top crossbeam and drop
        // straight in here.
        translate([cmf_rim_x, -24, cmf_z - cm_wall - 1]) rbox(30, 14, cm_wall + 2, 1.4);
        // POWER SWITCH: Ø12 barrel through the top wall, beside the rim slot.
        translate([cmf_sw_x, cmf_sw_y, cmf_z - cm_wall - 1])
            cylinder(d = cmf_sw_d, h = cm_wall + 2);
        // BACK WALL: power in from the battery.  Moved off the floor because the
        // converter now covers it, and placed above box-local Z 20 so it opens
        // into the gap between the two front crossbeams rather than into the
        // bottom beam itself.  The leads turn once here instead of doubling back
        // underneath the converter, which is the point.
        translate([cmf_grom_x, -cm_wall - 1, cmf_grom_z]) rotate([-90, 0, 0])
            cylinder(d = cmf_grom, h = cm_wall + 2);
        // Buck converter fixings: two M3 clearance holes through the floor, taking
        // its slotted end tabs.  These replace the zip-tie slots that used to live
        // here -- a 65 mm converter in a 66 mm interior leaves 0.5 mm a side, so
        // nothing could have been tied around it anyway.
        for (dx = [-cmf_buck_dx/2, cmf_buck_dx/2])
            translate([cmf_x/2 + dx, -cm_wall - cmf_buck_by, -1])
                cylinder(d = cmf_buck_bd, h = cm_wall + 2);
        // zip-tie slots up both side walls
        for (sx = [-1, cmf_x - cm_wall - 1], sz = [24, 48, 140])
            translate([sx, -cmf_y + 8, sz]) rbox(cm_wall + 2, cm_tie[1], cm_tie[0], 1);
    }
}

// -----------------------------------------------------------------------------
//  compute_box_front_populated  -- a LAYOUT AID, not a printable part
// -----------------------------------------------------------------------------
//  The box seen through its own opening with representative blocks where the
//  electronics go, so cable runs and free space can be judged before wiring.
//  Render in PREVIEW (no --render) so the colours survive.
//
//  MEASURED: the buck converter (65 x 35 x 15) and the La Frite outline (64 x 56)
//  and its M3 pattern.  Everything else is a plausible placeholder -- the fob,
//  PTT board, GPS module and the two right-angle adapters are sized from typical
//  parts, not from yours.  Move them by editing the table below.
//
//  Devices are drawn in the positions the geometry forces, not arbitrary ones:
//  the converter fills the floor, the board's M3 pattern fixes its position, and
//  the adapters have to live in the 21 mm between the board edge and the
//  converter.  The top bay is the only place with genuine freedom.
// -----------------------------------------------------------------------------
cmf_dev_fob  = [18, 52, 8];    // CM108/CM119 audio fob        W x H x D
cmf_dev_ptt  = [40, 22, 10];   // PTT board.  22 not 25: at 25 it fouls the
                               //   switch by 2 mm -- see below.
cmf_dev_gps  = [25, 25, 8];    // GPS module
cmf_dev_rj45 = [20, 18, 16];   // right-angle Ethernet adapter
cmf_dev_hdmi = [22, 16, 12];   // right-angle HDMI adapter
cmf_sw_body  = 30;             // MEASURED, with its cables connected.  This is
                               //   the number that fills the top bay: it puts the
                               //   switch body at Z 127..157, leaving only 24 mm
                               //   of height beneath it.  A PTT board taller than
                               //   ~23 mm will not pass under, and there is
                               //   nowhere else 40 mm wide for it to go.

module cmf_dev(pos, size, col) {
    color(col) translate([pos[0], pos[1], pos[2]])
        cube([size[0], size[2], size[1]]);   // W, D(into Y), H
}

module compute_box_front_populated() {
    %compute_box_front();                       // shell, ghosted

    // --- bottom bay: the converter, flat on the floor, filling it ---
    cmf_dev([cmf_buck_x[0], -cm_wall - cmf_buck[1], cmf_bay_buck[0]],
            [cmf_buck[0], cmf_buck[2], cmf_buck[1]], [0.85, 0.25, 0.20]);

    // --- the La Frite, on its four standoffs ---
    bz = cmf_bay_sbc[0];
    color([0.15, 0.55, 0.25])
        translate([cmf_x/2 - sbc_w/2, -cm_wall - sbc_stand - 1.6, bz])
            cube([sbc_w, 1.6, sbc_l]);
    // its connectors and eMMC, forward of the board
    color([0.20, 0.35, 0.20, 0.55])
        translate([cmf_x/2 - sbc_w/2 + 3, -cm_wall - sbc_stand - 1.6 - 14, bz + 3])
            cube([sbc_w - 6, 14, sbc_l - 6]);

    // --- the two right-angle adapters, in the 21 mm below the board edge ---
    cmf_dev([12, -cm_wall - sbc_stand - 14, bz - cmf_dev_rj45[1] - 1],
            cmf_dev_rj45, [0.90, 0.75, 0.15]);
    cmf_dev([40, -cm_wall - sbc_stand - 12, bz - cmf_dev_hdmi[1] - 1],
            cmf_dev_hdmi, [0.95, 0.60, 0.10]);

    // --- top bay: the only place with real freedom, and the switch takes some ---
    // Drawn standing 1 mm forward of the M4 bolt pads, which reach Y -8 across
    // Z 133.5..158.5.  Sitting a device flat on the back wall here overlaps them
    // by 2 mm; that is accepted rather than designed around, since the box is
    // bolted up once and not routinely removed.
    //
    // The switch body hangs into this bay from the top wall, so the devices are
    // arranged around it: the fob up the left edge, the PTT board low enough to
    // pass under the switch, the GPS beside it.  Body depth is a PLACEHOLDER --
    // only the bezel and barrel were given.
    // Fob rises off the board's USB ports, so its 52 mm is forced up the left
    // edge.  That leaves 24 mm of width beside it -- narrower than the PTT board --
    // so the PTT can only go UNDER the switch, and the GPS beside it.
    cmf_dev([4,  -cmf_boss - 1, 104], cmf_dev_fob, [0.20, 0.40, 0.85]);
    cmf_dev([23, -cmf_boss - 1, 104], cmf_dev_ptt, [0.95, 0.55, 0.15]);
    cmf_dev([22, -cmf_boss - 1, 130], cmf_dev_gps, [0.55, 0.30, 0.75]);
    color([0.30, 0.30, 0.33])
        translate([cmf_sw_x - cmf_sw_fp[0]/2, cmf_sw_y - cmf_sw_fp[1]/2,
                   cmf_z - cm_wall - cmf_sw_body])
            cube([cmf_sw_fp[0], cmf_sw_fp[1], cmf_sw_body]);
}

// -----------------------------------------------------------------------------
//  compute_box_front_cover
// -----------------------------------------------------------------------------
//  Full cover.  With the board rotated, its ports open along the board plane --
//  upward for USB, downward for power and Ethernet -- so nothing needs to pass
//  through this face and it can be solid.  Power and Ethernet are therefore
//  connect-before-closing.
//
//  A flat panel with a locating rim that nests inside the box opening, on six M3
//  screws.  The screw rows sit at Z 15 / 120 / 152, clear of the board footprint
//  at Z 44..108.
// -----------------------------------------------------------------------------
module compute_box_front_cover() {
    difference() {
        union() {
            rbox(cmf_x, cmf_z, cmf_cov_t, 1.4);
            // Locating RIM nesting inside the 74 x 154 opening -- a rim, not a
            // slab: a solid plate here cost 22 cm3 and stole 2 mm of interior
            // depth from a box with only 1 mm to spare over the SBC.  Sunk 1 mm
            // into the panel so it fuses instead of meeting it on a plane, which
            // left it as a separate shell.
            translate([cm_wall, cm_wall, cmf_cov_t - 1]) difference() {
                rbox(cmf_x - 2*cm_wall - 0.4, cmf_z - 2*cm_wall - 0.4,
                     cmf_cov_lip + 1, 0.8);
                translate([4, 4, -1])
                    rbox(cmf_x - 2*cm_wall - 8.4, cmf_z - 2*cm_wall - 8.4,
                         cmf_cov_lip + 3, 0.8);
            }
        }
        // Notch the rim's bottom band over the buck footprint so the converter can
        // sit flat on the floor.  Cut starts at Z = cmf_cov_t so the panel itself
        // stays intact -- only the 2 mm of rim standing proud of it is removed.
        translate([cmf_notch[0], cm_wall - 1, cmf_cov_t])
            cube([cmf_notch[1] - cmf_notch[0], 6, cmf_cov_lip + 2]);
        // No vent slots.  Eighteen 12 x 4 slots were judged of little practical
        // value in a bag-carried box, and they were sized back when the box also
        // breathed through a grid that no longer exists.  The cover is solid.
        // If an SDR goes inside, revisit airflow deliberately rather than by
        // reinstating these.
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
    color("#c9a227") translate([panel_t, beam_y_f, z_tb0 + ex])
        crossbeam(front_cols = front_cols);
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
else if (part == "crossbeam_top_front_dual")   crossbeam(front_cols = dual_cols);
else if (part == "crossbeam_top_front_triple") crossbeam(front_cols = triple_cols);
else if (part == "crossbeam_top_front_grid")   crossbeam(front_cols = grid_cols);
else if (part == "crossbeam_top_back")     crossbeam();
else if (part == "crossbeam_bottom_front") crossbeam(base_face = true);
// Same beam with a single row of accessory columns in its front face, so a tall
// front module (the compute box) bolts at the bottom as well as the top.  ONE
// row, not two: this beam's underside already carries the base-plate inserts
// over beam-local Z 0..9, and a second row at 6 would run straight into them.
// A row at 16 leaves 4.15 mm between the two sets of pockets.
else if (part == "crossbeam_bottom_front_rail")
    crossbeam(front_cols = grid_cols, front_rows = [16], base_face = true);
else if (part == "crossbeam_bottom_back")  crossbeam(base_face = true);

// flat on the bed, 70 x 78 x 12; one bridge over the grip aperture
else if (part == "handle")
    translate([handle_z2 - handle_z0, 0, 0]) rotate([0, -90, 0])
        translate([0, 0, -handle_z0]) handle();
else if (part == "handle_mic")
    // Same pose as `handle`: mating face DOWN.  The flip was only needed while
    // this part had a pocket opening onto the mating face; with the bracket doing
    // the capturing there is no pocket, so the sliced-flat mating face goes back
    // to being the best first layer available.  It also puts the M3 bracket
    // pockets face-up, where they are blind holes drilled downward rather than
    // bridged ceilings.
    translate([handle_z2 - handle_z0, 0, 0]) rotate([0, -90, 0])
        translate([0, 0, -handle_z0]) handle(mic = true);

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
else if (part == "compute_box_inline")
    translate([0, cmi_z, frame_d]) rotate([-90, 0, 0]) compute_box_inline();
else if (part == "compute_box_front")
    rotate([-90, 0, 0]) compute_box_front();
else if (part == "compute_box_front_cover") compute_box_front_cover();
// Layout aid, not printable.  Left in its own local frame so a front view looks
// straight into the opening; render in PREVIEW so the colours survive.
else if (part == "compute_box_front_populated") compute_box_front_populated();
else if (part == "battery_box")
    translate([-bb_x0, bb_tot_z, frame_d]) rotate([-90, 0, 0]) battery_box();
