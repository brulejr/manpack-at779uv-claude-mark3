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
part = "assembly"; // [assembly, exploded, side_panel, crossbeam_top_front_dual, crossbeam_top_front_grid, crossbeam_top_back, crossbeam_bottom_front, crossbeam_bottom_front_rail, crossbeam_bottom_back, crossbeam_top_front_triple, compute_box_inline, compute_box_inline_cover, compute_box_front_slim, compute_box_front_slim_cover, antenna_mount_bnc, antenna_mount_so239, battery_box]

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

// assembly views: swap base_plate for compute_box_inline + its cover.  They are
// alternatives -- the inline box's cover does the plate's job -- so this is a
// choice, not an addition.  It drops everything below it by 30 mm.
show_inline_box = false;

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
//  bay_h and base_t together decide where the bottom crossbeams sit.  Raising them
//  is what makes the unified panel+handle printable: the panel starts where the
//  beams start, so the PART gets shorter while the frame's overall height, the top
//  beams, the accessory rail, the radio and everything above stay exactly put.
//  116 / 8 put the panel at Z 16 and the part at 184 mm -- 4 mm over the bed.
//  107 / 17 put it at Z 25 and the part at 175 mm, with 5 mm of margin.
//  The 9 mm comes out of the 38.5 mm of dead space under the radio, which still
//  leaves 29.5 mm there for the DC harness.
bay_h    = 107;    // clear Z between the bottom and top crossbeams
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
handle_lap  = 48;    // lap length onto the panel's outer face
// --- unified side panel + handle ---
//  The handle is no longer a separate part lapping the panel's outer face; it is
//  the same 9 mm plate, continuing up past the frame top into an arch.  That
//  removes 12 mm per side from the assembled width: 166.25 -> 142.25.
//
//  The part is 175 mm tall, and getting under the Mini's 180 bed is what sets its
//  bottom edge.  The grip aperture floor cannot drop below the radio top at
//  Z 179.5 -- lower than that and fingers are inside the radio -- so the 20 mm of
//  grip above the frame is fixed and the height had to come off the bottom.
//  All four beams keep their original insert rows -- 22.5 / 33.5 bottom and
//  162.5 / 173.5 top -- so no crossbeam changes and nothing already printed needs
//  reprinting.  The panel carries all eight bolts as before.    // the handle sits in a POCKET in the panel's outer face, so
                     //   it stands 8 mm proud instead of 12.  That is 8 mm off the
                     //   assembled width, 166.25 -> 158.25.
                     //   It also forces the handle's own bolts to go: their heads
                     //   were counterbored 4 mm into the INNER face, and 9 - 4
                     //   recess - 4 counterbore leaves 1 mm of panel under a bolt
                     //   head.  So the handle now SHARES the top-crossbeam bolts
                     //   instead -- same Y, and tb_z already falls inside the lap.

// =============================================================================
//  DERIVED
// =============================================================================
frame_w = radio_w + 2 * panel_t;      // 142.25
z_frame = 25;                         // panel & beam bottoms.  A BARE DATUM: it
                                      // was foot_h + base_t, but the base plate is
                                      // gone and nothing sits below it now.  Moving
                                      // it would move the panels' bolt rows, so it
                                      // stays at the value that plate gave it.
panel_z0 = z_frame;                   // The panel must cover the bottom crossbeams,
                     //   which span Z 16..40.  Trimming it leaves them protruding
                     //   and puts the bolt holes off the beams' insert rows.
z_bb0   = z_frame;                    // 16   bottom beams
z_bb1   = z_bb0 + beam_h;             // 40
z_tb0   = z_bb1 + bay_h;              // 156  top beams
z_tb1   = z_tb0 + beam_h;             // 180  panel top

beam_y_f  = 0;
beam_y_b  = frame_d - beam_d;         // 54
beam_cy_f = beam_d / 2;               // 8
beam_cy_b = frame_d - beam_d / 2;     // 62

// beam-end bolts: two per end, stacked in Z so the joint cannot rotate
beam_dz = 5.5;
bb_rows = [beam_h/2 - beam_dz, beam_h/2 + beam_dz];        // 6.5, 17.5 beam-local
bb_z = [z_bb0 + bb_rows[0], z_bb0 + bb_rows[1]];          // 22.5, 33.5 -- UNCHANGED
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
//  Set by the FRAME TOP, not the bay centre: the radio's control face sits 0.5 mm
//  below z_tb1 in both cases.  The old form centred the RT-95 in the bay and only
//  coincidentally landed there, so it moved whenever bay_h changed.  Both
//  expressions give the same numbers as before, 98 and 129.
radio_bz_rt95 = z_tb1 - 0.5 - rt95_d / 2;           // 98
radio_bz_at779= z_tb1 - 0.5 - at779_d / 2;          // 129
radio_bz_all  = [radio_bz_rt95, radio_bz_at779];
radio_bz = (radio == "rt95") ? radio_bz_rt95 : radio_bz_at779;
radio_z0 = radio_bz - radio_d / 2;
radio_z1 = radio_bz + radio_d / 2;

// handle
handle_z0 = z_tb1 - handle_lap;               // 132
                     //   runs handle -> panel -> beam insert, head countersunk in
                     //   the handle.  Was [140, 152] with the handle bolted to the
                     //   panel and the panel separately bolted to the beam.
grip_y0   = (frame_d - grip_ap_len) / 2;      // 18.125
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
                                 //   leaves the mic lead somewhere to run
                                 //   the bracket clears it.  Top still follows the
                                 //   arch, so the grip band is untouched at 7 mm.
                                 //   are the joints that must not read as notches

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
// -----------------------------------------------------------------------------
//  BATTERY-BOX TABS -- the bottom frame-to-module joint
// -----------------------------------------------------------------------------
//  The battery box carries two tabs per side that stand in the space the bottom
//  crossbeams' ends used to occupy, immediately inboard of each side panel.  The
//  bolts then run panel -> tab -> beam insert, so the module is captured by the
//  same fixings that hold the frame together instead of hanging off a plate.
//
//  Consequences, both deliberate:
//    * the base plate has nothing left to do and is dropped from the assembly;
//    * the bottom beams lose 2 x tab_t of length, and therefore CANNOT reach the
//      panels without the battery box.  The box is now a structural member of
//      the frame, not an accessory.
//
//  The frame's own geometry is untouched -- z_frame stays 25, so the panels'
//  bolt rows do not move and neither panel needs reprinting.
tab_t     = panel_t;                          // 9, tab fills the panel's thickness
tab_x     = [panel_t, frame_w - panel_t - tab_t];   // 9, 124.25
bb_span   = radio_w - 2 * tab_t;              // 106.25, shortened bottom beam
bb_beam_x = panel_t + tab_t;                  // 18, where that beam now starts
assert(bb_span > 0, "tabs are wider than the frame's clear span");

base_bolt_x = [35, frame_w - 35];             // 35, 107.25
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
//  Floor dropped to Z 32, which leaves a 7 mm band along the panel's bottom edge --
//  the same section as the arch band at its apex, so the part is evenly loaded top
//  and bottom.  Nothing stops it going this low: Y 16..54 is the gap BETWEEN the
//  two bottom crossbeams, and the beam bolts sit at Y 8 / 62 with 3.9 mm of
//  material between their counterbores and the window edge.
win_a = [16, 32, 54, 74];    // y0 z0 y1 z1
//  win_b is GONE.  The grip aperture now runs down to Z 150 in its place, so the
//  band of panel that used to sit above the top crossbeam screws -- tying the
//  front and back legs together -- is removed.  The arch does that job.
//  The screws never constrained this: they sit at Y 8 / 62 and the aperture spans
//  Y 18..52, so the two do not overlap at all.
grip_floor = 150;
grip_round = 2;      // edge radius on the arch, through the plate's 9 mm.  2 rather
                     //   than the old handle's 2.5, because the bar is 9 mm thick
                     //   now instead of 12 -- this still leaves 5 mm of flat.

// =============================================================================
//  DERIVED-DIMENSION REPORT
//  Printed on every render so the fit assumptions stay visible.  radio_h and
//  radio_d are the two numbers to re-measure against the radio in hand: they
//  drive frame_d and bay_h respectively.
// =============================================================================
BED = 180;
echo(str("frame body            = ", frame_w, " x ", frame_d, " x ", z_tb1, " mm"));
echo(str("assembled envelope    = ", frame_w, " x ",
         frame_d + ant_leg_t + max(bnc_reach, so239_reach), " x ",
         handle_z2, " mm  (depth shown for the deeper SO-239 bracket)"));
echo(str("radio bay (WxDxH)     = ", radio_w, " x ", frame_d - 2 * beam_d,
         " x ", bay_h, " mm"));
echo(str("radio clearance  side = ", (frame_d - 2 * beam_d - radio_h) / 2,
         " mm/side   above/below = ", (bay_h - radio_d) / 2, " mm"));
panel_print_h = handle_z2 - panel_z0;   // 175, the unified part's long side
echo(str("panel print footprint = ", panel_print_h, " x ", frame_d,
         "  (bed ", BED, ") -> margin ", BED - panel_print_h, " mm"));
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
// panel_h is only the plate portion now; the part that has to fit the bed is the
// panel PLUS the integral handle, panel_z0 up to handle_z2.
assert(panel_print_h <= BED && frame_d <= BED,
       str("unified side panel is ", panel_print_h, " mm, bed is ", BED));
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
        union() {
            // OUTER face and the whole perimeter rounded, INNER face left dead
            // flat.  The inner face is what the crossbeams land on -- their
            // footprints run right out to Y 0 and Y 70 -- so it cannot be
            // softened.  Rounding the whole part in one operation is what keeps
            // the handle/panel junction smooth: an arch-only fillet left a 2 mm
            // ledge across the part at Z 180, exactly where a hand wraps.
            //
            // Shrink the profile by the radius, extrude it short of the inner
            // face, then minkowski a sphere back on and slice at the inner face.
            // ...up to the frame top only.  Above it the arch replaces this, so
            // the two must be cut apart rather than unioned: the arch version is a
            // SUBSET of this one, and a union would silently keep this one.
            difference() {
                translate([0, 0, handle_z0]) rotate([90, 0, 90])
                    difference() {
                        minkowski() {
                            translate([0, 0, grip_round])
                                linear_extrude(height = panel_t - grip_round)
                                    offset(r = -grip_round) panel_profile();
                            sphere(r = grip_round, $fn = 16);
                        }
                        translate([-200, -200, panel_t]) cube([400, 400, 400]);
                    }
                translate([-1, -1, z_tb1]) cube([panel_t + 2, frame_d + 2, 60]);
            }
            // Above the frame top there is no beam to seat, so the INNER face is
            // rounded too and the grip is soft on both edges.  The resulting step
            // on the inner face sits at Z 180, which is the top crossbeam's own
            // top edge.
            intersection() {
                translate([grip_round, 0, handle_z0]) rotate([90, 0, 90])
                    minkowski() {
                        linear_extrude(height = panel_t - 2 * grip_round)
                            offset(r = -grip_round) panel_arch_profile();
                        sphere(r = grip_round, $fn = 16);
                    }
                translate([-1, -1, z_tb1]) cube([panel_t + 2, frame_d + 2, 60]);
            }
        }

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

        // --- lightening / ventilation windows ---
        if (panel_windows)
            translate([-1, 0, 0]) window_x(panel_t + 2, win_a);
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
//  `span` is the beam's length and `x0` the frame X it starts at.  The two differ
//  between top and bottom beams now: the top pair still run panel face to panel
//  face, the bottom pair stop short by tab_t at each end to leave room for the
//  battery box's tabs.  x0 is what maps frame X (grid_cols, base_bolt_x) into
//  beam-local X, so it has to travel with span.
module crossbeam(front_cols = [], base_face = false,
                 rows = [beam_h/2 - beam_dz, beam_h/2 + beam_dz],
                 span = radio_w, x0 = panel_t) {
    difference() {
        rbox(span, beam_d, beam_h);

        // two inserts per end, axis along the span
        for (rz = rows) {
            translate([0, beam_d/2, rz])
                rotate([0, 90, 0]) m4_insert();
            translate([span, beam_d/2, rz])
                rotate([0, -90, 0]) m4_insert();
        }

        // top-front beam: accessory bolt columns in its FRONT face
        for (gx = front_cols, z = rail_z)
            translate([gx - x0, 0, z - z_tb0])
                rotate([-90, 0, 0]) m4_insert();

        // `base_face` is retained as a parameter but nothing passes it now.  The
        // base plate is gone, and compute_box_inline hangs off the battery box
        // rather than bolting up into these beams, so the four underside inserts
        // they used to carry have no user left.
        if (base_face)
            for (gx = base_bolt_x)
                translate([gx - x0, beam_d/2, 0]) m4_insert();
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
// The unified panel's silhouette: the same outer shape as the handle, but with the
// straight-sided lap carried all the way down to panel_z0, and the grip aperture
// FLOORED at the frame top.  On the bolt-on handle the aperture ran out through
// the bottom edge and the panel closed it; here the panel is the same part, so the
// aperture has to stop at Z 180.
//  The arch only, from a little below the frame top upward.  Rounding is applied
//  to this region alone: a minkowski over the whole 175 mm profile would be slow
//  and would round the panel's straight sides too.
module panel_arch_profile() {
    intersection() {
        panel_profile();
        translate([-10, z_tb1 - handle_z0 - 12]) square([frame_d + 20, 400]);
    }
}

module panel_profile() {
    difference() {
        handle_outer(extend = handle_z0 - panel_z0);
        round2d(4) intersection() {
            translate([grip_y0, grip_floor - handle_z0]) square([grip_ap_len, 400]);
            offset(r = -grip_bar_h) handle_outer(extend = 40);
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
// The box top IS the frame datum now.  It used to hang below the base plate with
// its top at Z 0; with the plate gone the frame lands straight on this face and
// the tabs rise off it into the bottom beams.  Everything below moves up by 25.
bb_z1    = z_frame;                              // 25, the face the frame sits on
bb_z0    = bb_z1 - bb_out_z;                     // -26.8, underside of the floor
bb_cz1   = bb_z1 - (box_boss + 1);               // 16,    cavity ceiling
bb_cz0   = bb_cz1 - bb_cav_z;                    // -47.8, cavity floor
bb_bat_y1= bb_y0 + bb_out_y - box_wall;          // 66, pack seats against the back
bb_tot_z = bb_out_z + foot_h;                    // 59.8, including the feet
// Side strips of floor left solid to carry the stacking feet, and the clear
// band between the two foot zones where a window can still go.

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
                translate([fx, bb_y0, bb_z1 - box_boss])
                    rbox(box_wall + flange_w, bb_out_y, box_boss, 1.5);
            // Stacking feet: the same four the base plate used to present, at the
            // same X/Y, so compute_box_inline hangs under this box on exactly the
            // joint the box itself used to make upward.  Restored because the
            // compute module now lives BELOW the battery rather than above it --
            // that keeps the frame's bottom bracing entirely inside this box's
            // 8 mm flange instead of running it through the compute tray's 3 mm
            // cavity walls.
            for (x = foot_x, y = foot_y)
                translate([x, y, bb_z0 - foot_h])
                    cylinder(d = foot_d, h = foot_h + 1);
            // TABS: two per side, one under each bottom crossbeam, standing in the
            // space that beam's end used to occupy.  They run only over the beams'
            // Y bands, not the full depth -- the radio occupies Y 17..53 at this
            // height and a full-depth tab would foul it.
            //
            // They rise from the flange, which already spans this X: the flange
            // reaches flange_w inboard of each end wall, i.e. to X 23.125 and
            // 119.5, so both tab footprints sit on solid material.
            // Sunk 1 mm into the flange: sitting exactly on bb_z1 makes each tab
            // a separate shell, coplanar contact rather than a union.
            for (tx = tab_x, ty = [beam_y_f, beam_y_b])
                translate([tx, ty, bb_z1 - 1])
                    rbox(tab_t, beam_d, beam_h + 1, 1.5);
        }
        // The tabs' bolt clearance: the panel's own counterbore takes the head, so
        // these are plain through-holes on the beams' two rows.
        for (tx = tab_x, y = [beam_cy_f, beam_cy_b], z = bb_z)
            translate([tx - 1, y, z]) rotate([0, 90, 0])
                cylinder(d = m4_clear, h = tab_t + 2);
        // inserts for the module below, opening downward through the feet
        for (x = foot_x, y = foot_y)
            translate([x, y, bb_z0 - foot_h]) m4_insert();
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
        // strap slots through both end walls, in the clear zone ahead of the pack
        for (wx = [bb_x0 - 1, bb_x0 + bb_out_x - box_wall - 1])
            translate([wx, bb_y0 + strap_zone/2 - strap_t/2,
                       bb_cz0 + bb_cav_z/2 - strap_w/2])
                rbox(box_wall + 2, strap_t, strap_w, 1.2);
    }
}

echo(str("battery frame outer   = ", bb_out_x, " x ", bb_out_y, " x ", bb_tot_z,
         " mm (", bb_out_z, " to the floor + ", foot_h, " of stacking feet), plus ",
         beam_h, " mm of tab standing into the bottom crossbeams; reaching ",
         -bb_y0, " mm forward of the frame, nothing behind it"));
echo(str("bottom beam span      = ", bb_span, " mm (was ", radio_w,
         "); the frame does not close without the battery box"));
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
sbc_stand_hi = 8;    // used by both front boxes.  8 is the MINIMUM that still
                     //   houses the insert: pocket 7.5 leaves 0.5 mm of boss above
                     //   the wall face, with the 3 mm back wall behind that.  Was
                     //   10, sized to give a generous DC channel under the board;
                     //   the side cable-tie mounts now carry the long runs, so the
                     //   channel only has to get power across to the board and
                     //   8 mm does that.
sbc_ins_h = 7.5;     // M3 pocket depth: the inserts are 7 mm long, plus 0.5 mm of
                     //   relief so they can seat flush and displaced material has
                     //   somewhere to go.  Was 6, which was short of the insert.
m3_ins_d  = 4.0;     // M3 heat-set insert pilot
m3_ins_h  = 5.0;
m3_clear  = 3.4;     // M3 clearance hole for the generic grid
cm_wall   = 3;

// --- cable-tie mounts for the two FRONT boxes ---
//  A PAIR of slots with a ligament between them, not a single slot.  A single
//  slot does not retain a tie: thread one through, round the bundle and back out
//  the same opening, and the bight on the outside spans nothing and pulls
//  straight back through.  The tie has to cross a ligament on the OUTER face --
//  in one slot, over the bridge, back in the other, then round the bundle.
//  The earlier single slots were also spaced 24 / 92 mm apart, which left the
//  whole middle of the box unsupported for a run along its length.
cmf_tie      = [3, 8];   // each slot, Z tall x Y long
cmf_tie_lig  = 4;        // wall left between the pair, for the tie to cross
cmf_tie_z    = [25, 50, 75, 95, 110];    // BOTH walls.  Z 110 is the highest that
                         //   clears the SMA bulkhead at Z 114.75..121.25, by
                         //   3.25 mm.
cmf_tie_z_hi = [130, 150];               // the CLEAR wall only.  The switch body
                         //   hangs from the panel underside at Z 155 down to
                         //   Z 125 and leaves 1 mm of side gap next to it, so
                         //   these two heights are worthless on the switch side --
                         //   but the opposite wall has 33 mm there and keeps them.
                         //   (The 2 mm bezel recess pad lowered that underside
                         //   from 157, so the body reaches 2 mm further down than
                         //   the bare bezel depth suggests.)
                         //   Which wall is clear differs between the two boxes:
                         //   the deep box has its switch on the left, the slim box
                         //   on the right, so the high mounts mirror.
//  Deep box only: the mounts sit REARWARD of the depth centre, at Y -15 rather
//  than -20.  Centred, their near slot stopped at Y -14 and the under-board
//  channel ends at Y -13, so nothing in that channel could be tied down at all.
//  At -15 the near slot runs Y -13..-5 and straddles it.  The slim box needs no
//  such offset -- it is shallow enough that its centreline already reaches.

//  Cut from X -1 running +X, so place it at the wall's INNER face.
module cm_tie_mount(wall_t) {
    for (sgn = [-1, 1])
        translate([-1, sgn * (cmf_tie_lig + cmf_tie[1]) / 2 - cmf_tie[1] / 2,
                   -cmf_tie[0] / 2])
            rbox(wall_t + 2, cmf_tie[1], cmf_tie[0], 1);
}

// --- inline variant ---
                     //   board clears the top flanges

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
                     //   converter lies flat with its 35 mm dimension running
                     //   front-to-back, so interior depth had to reach 37.
                     //   Still inside the 50 mm envelope.
cmf_bolt  = 28;      // bolt column spacing = grid columns 5 and 7 (85.125 and
                     //   113.125), the pair that lands inside a 72 mm box sitting
                     //   right of an antenna mount
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
// --- cover ---
// --- buck converter, MEASURED 35 H x 65 W x 15 D, wires off the 35 mm end ---
//  It lies flat on the floor: 65 across X, 35 front-to-back, 15 tall.  That is
//  the pose that costs the least height, which is what the connector gap above it
//  is short of.  65 is the OVERALL width including its mounting ears, and it goes
//  into the 66 mm interior as-is -- the box does not widen for it.  Depth is the
//  one dimension that had to give: 35 front-to-back needs 37 of interior.
cmf_buck_x   = [(cmf_x - 2*cm_wall - 65)/2 + cm_wall,
                (cmf_x - 2*cm_wall + 65)/2 + cm_wall];   // 3.5 .. 68.5
//  Mounting: the LY-KREE XS120503 has a slotted fork tab at each end, so two
//  fixings, not four.  MEASURED 54 mm apart and 13.5 mm in from the back.
//  The 65 mm overall is across the tabs, so the holes land 5.5 mm inboard of each
//  end -- which is consistent, and is why the datum below is read as the INSIDE
//  face of the back wall rather than the outside: the converter registers against
//  that face, and 13.5 from it falls inside the 35 mm footprint.
                                         //   holes, screw from underneath.  The
                                         //   tabs are slotted, so they absorb the
                                         //   tolerance a round hole does not.
//  Power now enters through the BACK WALL rather than the floor -- the converter
//  is sitting where the floor hole used to be, and coming in at the back lets the
//  12 V leads turn once into the frame instead of doubling back under the module.
cmf_grom     = 12;   // grommeted power entry, now in the back wall
                     //   the 12 V run away from the Ethernet and HDMI adapters,
                     //   which hang off the board's downward edge.  Left/right is
                     //   as seen looking INTO the opening with the M4 pads at top:
                     //   in that view low X is screen-left.  Ø12 at X 12 spans
                     //   6..18 -- inside the first quarter, 3 mm off the interior
                     //   wall at X 3.
                     //   occupies global Z 16..40 = box-local -4..20, so the back
                     //   wall is flat against beam material below box-local 20 and
                     //   a hole there would open into the beam, not the frame.
                     //   Ø12 at 28 spans 22..34: 2 mm clear of the beam, 5 mm
                     //   below the board edge at 39.
                     //   around the opening, projecting 2 mm in over Z 3..7.  With
                     //   a 35 mm converter in a 37 mm interior there is nothing to
                     //   give, so the bottom rim is now notched over its whole
                     //   width.  Three sides still locate the cover; six screws
                     //   hold it.
// --- top wall: switch, USB bulkhead, rim slot ---
//  The missile switch is a Ø12 barrel under a big flip-cover bezel.  It sits on
//  the LEFT, over the 12 V entry at X 12, so the switched 12 V pair stays on that
//  side -- the same arrangement as the slim box, where the switch also sits over
//  its own power entry.  It was previously on the right, 46 mm from its supply.
//
//  The bezel is ROTATED from the first attempt: 32 across X and 20 through the
//  depth, rather than 20 x 32.  At 32 deep it spanned Y -4..-36 and swallowed the
//  whole depth; at 20 it sits Y -10..-30, genuinely centred, and clears the M4
//  pads (which stop at Y -8) by 2 mm.
                          //   that positions the hole and must clear its neighbours.
cmf_sw_d     = 12;        // panel hole for the barrel
//  The switch cover's base plate sits in a 2 mm RECESS so it finishes flush with
//  the top face instead of standing proud.  The plate carries a tab that overhangs
//  the box's top-left corner by ~7 mm and gets folded down the side wall with
//  pliers, so the recess runs out to the left edge and a matching notch is cut
//  into the outer face of the left wall to receive the fold.  Both exist to stop
//  a bare metal corner catching on the bag.
//
//  The top wall is only 3 mm, so a 2 mm recess would leave 1 mm.  It is therefore
//  thickened by 2 mm on the INSIDE over the same footprint, and the recess brings
//  it back to the original 3 mm.  Cost is 2 mm of top-bay height, taken exactly
//  where the switch body already sits.
//  The side notch is the SAME WIDTH as the top recess -- the folded tab is part of
//  the same plate, so the two have to line up or the fold sits on a step.  It was
//  briefly 12 mm against the recess's 20, which left a 4 mm shoulder each side.
//  Depth into the wall matches the recess at 2 mm; 9 mm down the side gives the
//  ~7 mm fold some margin.

//  USB bulkhead: Ø12 with the top and bottom flattened to 11 mm across, which is
//  the connector's own anti-rotation form.  ASSUMED the flats run across the
//  DEPTH (11 measured in Y, 12 in X); if the connector keys the other way this
//  rotates 90 deg and is a one-line change.
cmf_usb_d    = 12;
cmf_usb_flat = 11;
                          //   spans Y -14..-26, clear of the M4 pads by 6 mm.
//  SMA bulkhead in the RIGHT side wall, for a WiFi dongle with an external
//  antenna.  It goes in the one clear band on that wall: below the M4 pads, which
//  start at Z 133.5, and above the board, which tops out at Z 103.  Ø6.5 at Z 118
//  leaves 11.75 mm above the board and 12.25 mm below the pads, and the nearest
//  zip-tie slot is 22 mm away at Z 140.
//  Ø6.5 is the usual panel hole for a 1/4-36 SMA bulkhead.  NOTE the wall is 3 mm,
//  which is at the top of the panel thickness most SMA bulkheads accept -- check
//  the thread length on yours before printing.

//  The 30 x 14 top rim slot is GONE.  It carried the audio, PTT and GPS leads
//  down from the radio's control face, and it shared this end of the top wall
//  with the USB hole -- two openings where one will do.
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


// 4 x M3 bosses on the SBC pattern, standing sbc_stand tall from Z=0
// Sunk 1 mm into whatever they stand on: butting them at exactly Z=0 left the
// pads sharing only a plane with the floor, which printed the inline box as five
// separate shells.
module sbc_pads(h = sbc_stand) {
    for (dx = [-sbc_hx/2, sbc_hx/2], dy = [-sbc_hy/2, sbc_hy/2])
        translate([dx, dy, -1]) cylinder(d = 8, h = h + 1);
}
module sbc_pad_pockets(h = sbc_stand) {
    for (dx = [-sbc_hx/2, sbc_hx/2], dy = [-sbc_hy/2, sbc_hy/2])
        translate([dx, dy, h - sbc_ins_h])
            cylinder(d = m3_ins_d, h = sbc_ins_h + 0.1);
}

// Topology deliberately mirrors battery_box, which is the one shape already
// proven to print on this frame: back wall, two end walls, a floor, full-length
// top flanges carrying the M4s, feet below, and open at the FRONT and TOP.
// Floor-down would put the feet on the bed under a full-width floor -- the same
// mid-air failure the base plate had -- and a closed front would become a
// 142 x 49 ceiling in the back-down pose.  Open front doubles as the port
// access: the SBC sits with its connector edge facing out of it.
// (compute_box_inline is redefined below -- see PART 11a)



// =============================================================================
//  PART 11a -- compute_box_inline + compute_box_inline_cover
// -----------------------------------------------------------------------------
//  A stack module carrying the La Frite and its converter, on the battery box's
//  footprint.  It sits at the BOTTOM of the stack, hanging from the battery box's
//  four stacking feet on 4 x M4 x 12 -- the same joint the battery box used to make
//  upward to the base plate.
//
//  It carries NO frame load.  An earlier revision put the frame's bottom tabs on
//  this tray, which ran the whole bottom bracing through four 9 x 16 columns
//  standing on wedges off 3 mm cavity walls.  Under the battery instead, the tabs
//  stay on the battery box's 8 mm flange where they belong and this box only has to
//  hold itself up.
//
//  Two parts, because the cover's rear bolts at Y 62 end up enclosed by the tray:
//  bolt the cover to the frame first, then screw the tray up onto it.  The tray
//  then drops off for servicing without disturbing the frame or the battery.
//
//  55 mm overall, from the frame's underside at Z 25 down to Z -30:
//      cover   8   Z  17..25   4 x M4 into the crossbeams
//      cavity 35   Z -18..17   contents need 24.6
//      floor   4   Z -22..-18
//      feet    8   Z -30..-22  M4 inserts for the module below
// =============================================================================
cmi_w    = bb_out_x;                   // 143, the battery box's width
cmi_d    = 100;                        // 5.2 mm DEEPER than the battery box's
                                       //   94.8.  That is what lets the converter
                                       //   sit BEHIND the board rather than beside
                                       //   it, freeing the board's whole X band:
                                       //   connector zones go 19 -> 36.5 mm each.
                                       //   The board's connectors are on its two
                                       //   short edges, so anything sharing that
                                       //   band comes straight off them.  Cost: it
                                       //   reaches 30 mm forward of the frame
                                       //   instead of 24.8.
cmi_x0   = bb_x0;                      // -0.375
cmi_y0   = frame_d - cmi_d;            // -30, back flush with the frame
//  It hangs from the battery box's four stacking feet, so its TOP face is their
//  underside, not the frame datum.  The compute module is the bottom of the stack
//  now -- see the section header.
cmi_top  = bb_z0 - foot_h;              // -34.8, the battery box's feet land here
cmi_cov_t= 8;                          // cover thickness
cmi_wall = 3;
cmi_floor= 4;
cmi_z1   = cmi_top - cmi_cov_t;        // 17, tray top
cmi_z0   = cmi_z1 - 35 - cmi_floor;    // -22, underside of the floor

//  The board lies with its LONG axis ACROSS the tray.  Front-to-back does not
//  work: its connectors are on both 56 mm edges -- USB one end, Ethernet/HDMI the
//  other -- and 64 of board plus 20 of clearance at each end is 104 against only
//  88.8 mm of depth.  Across the tray the same 104 fits in 137 with room to spare.
//
//  Beside the board the converter would cost 35 mm of the X band: 64 + 35 = 99
//  leaves 38 mm to split between the two connector zones, about 19 mm each.  That
//  is what the extra 5.2 mm of depth buys -- at 100 deep the converter stacks
//  BEHIND the board (56 + 35 = 91 against 94 of interior) and both zones go to
//  36.5 mm.  That is the whole packing problem in one line.
//  Board hard against the FRONT wall, centred across; converter BEHIND it, biased
//  toward the notch so the power wiring stays on one side.
//  Y -25.75, not -27: hard against the front wall the standoff pads merged 0.75 mm
//  INTO it and the board's edge was dead flush.  The pads overhang the board by
//  0.75 each end, so of the 3 mm of slack in this direction 1.5 is theirs; the
//  rest is split 0.5 pad-to-wall, 0.5 pad-to-converter, 0.5 converter-to-back.
cmi_sbc  = [39.125, -25.75, 64, 56];   // La Frite  x0 y0 w d
cmi_stand = sbc_stand_hi;              // 8
//  In the pocket behind the board, 0.5 mm off the back wall (inner face Y 67).
//  It used to be 0.5 mm off the raceway wall too, back when the raceway was a notch
//  in the back wall beside it; the raceway has since moved inboard and right, so
//  there is now 16.75 mm of free cavity to the converter's right (X 96.5 to the
//  shaft wall at 113.25).  Left where it is -- nothing else needs that space and
//  the position is already printed.
cmi_conv = [31.5, 31.5, 65, 35];       // converter, flat, behind the board
cmi_conv_dy = 54;                      // its tab holes, 54 apart along its length
cmi_conv_dx = 13.5;                    //   and 13.5 in from one edge
//  It used to be held by two M3 straight THROUGH the floor.  With this box at the
//  bottom of the stack that floor is the ground face, and two Ø3.4 holes in it are
//  an ingress path, so the hold-down is now blind: two pads with insert pockets that
//  stop short of the outside.
//
//  Wall-mounting it instead does not fit, which is worth recording.  The mounting
//  holes are in its 65 x 35 face, so bolting that face to a wall puts both 65 and 35
//  in the wall plane; 65 cannot go vertical in a 35 mm cavity, so 35 must -- and the
//  cavity is exactly 35.00 mm.  Zero clearance.  Making it work would mean a floor
//  recess for clearance plus local pads to give a 3 mm wall enough depth for a 5 mm
//  insert, and on the SIDE wall it would also sit squarely in the board's right
//  connector zone.  Not worth it when a blind pad closes the floor for nothing.
cmi_conv_pad_d = 10;
cmi_conv_pad_h = 3;                    // lifts the converter clear for wiring too
assert(cmi_floor + cmi_conv_pad_h - m3_ins_h >= 1.5,
       "converter insert pocket breaks through the tray floor");
//  RACEWAY: a walled vertical SHAFT through the tray and cover, isolated from the
//  electronics cavity by 3 mm on every inboard face.  It was a notch in the back
//  wall, which does not survive the cover taking over the base plate's job:
//
//    - the back bottom crossbeam lands on the cover at Y 54..70, so a channel at
//      Y 62..70 emerged directly underneath it and dead-ended;
//    - that beam's own M4 at (107.25, 62) sat inside the old notch footprint.
//
//  NO RACEWAY.  It existed to carry the battery's leads up past this module to the
//  radio, which only made sense while the box sat between them.  With the battery
//  directly under the frame its leads go straight up past its own flange into the
//  bay, and this box's 12 V comes DOWN a short run from the battery above it.  So
//  the side-wall channel is gone -- along with the four attempts it took to place
//  it -- and what replaces it is a single grommeted entry in the cover.
//
//  Same Ø12 grommet the front box's power entry uses, so nothing new to source.
//  Sited just clear of the converter's lead end at X 96.5 and centred on its Y band,
//  so the feed drops straight onto the terminals instead of crossing the board.
cmi_grom    = cmf_grom;                // 12
cmi_grom_x  = cmi_conv[0] + cmi_conv[2] + cmi_grom/2 + 2.5;   // 105, clear of the converter
cmi_grom_y  = cmi_conv[1] + cmi_conv[3]/2;                    // 49, on its centreline
assert(cmi_grom_x - cmi_grom/2 > cmi_conv[0] + cmi_conv[2],
       "cover grommet overlaps the converter");
assert(min([for (x = foot_x, y = foot_y) sqrt(pow(x - cmi_grom_x, 2)
                                            + pow(y - cmi_grom_y, 2))])
       > cmi_grom/2 + m4_cb_d/2,
       "cover grommet fouls a stacking bolt");
//  TRAY -> COVER: six M3 driven HORIZONTALLY, from outside, through the tray's side
//  walls into lugs hanging off the cover's underside.
//
//  Vertical screws do not work here, and it is worth writing down why.  The cover
//  has to bolt UP into the battery box's feet, so those four heads sit on its
//  underside -- inside the box, unreachable once the tray is on.  Putting the tray
//  screws through the cover's TOP face then traps them the other way: they end up in
//  the 8 mm gap between the cover and the battery box's floor, which the feet hold
//  open and nothing can reach into.  Bolts facing opposite ways with no order that
//  gets at both.
//
//  Horizontal screws break the deadlock.  Order becomes: cover up to the battery
//  (4 x M4 from below, nothing under it yet), populate the tray, lift it up, then six
//  M3 from outside the side walls.  Every fastener is reachable when it is needed and
//  the ground face stays sealed.
//
//  Lug Y positions dodge the M4 counterbores' Y bands (7.9..16.1 and 53.9..62.1) so
//  the lugs can be a full 10 mm deep without crowding them, and they sit in the top
//  10 mm of the cavity -- headroom above the board, not beside it.
cmi_lug     = [10, 12, 10];            // X into the cavity, Y long, Z below the cover
cmi_lug_ys  = [-20, 25, 45];
cmi_lug_ax  = cmi_z1 - 5;              // screw axis, 5 mm below the cover's underside
//  [wall inner face, direction into the cavity]
cmi_lug_w   = [[cmi_x0 + cmi_wall, 1], [cmi_x0 + cmi_w - cmi_wall, -1]];
assert(cmi_lug[0] >= m3_ins_h + 2,
       "cover lug too shallow to back an M3 insert");

module compute_box_inline_cover() {
    // lugs for the tray's horizontal M3s, sunk 1 mm into the plate so they union
    // with it rather than meeting it on a plane
    for (w = cmi_lug_w, y = cmi_lug_ys)
        difference() {
            translate([w[1] > 0 ? w[0] : w[0] - cmi_lug[0], y - cmi_lug[1]/2,
                       cmi_z1 - cmi_lug[2]])
                cube([cmi_lug[0], cmi_lug[1], cmi_lug[2] + 1]);
            translate([w[0], y, cmi_lug_ax]) rotate([0, w[1] * 90, 0])
                cylinder(d = m3_ins_d, h = m3_ins_h + 0.01);
        }
    difference() {
        translate([cmi_x0, cmi_y0, cmi_z1]) rbox(cmi_w, cmi_d, cmi_cov_t, 2);
        // Four M4 UP into the battery box's stacking feet -- the same joint the
        // battery box used to make to the base plate, just one level lower.  The
        // counterbore is on the cover's UNDERSIDE, so the head sits inside the box
        // and 4 + 7 keeps it on M4 x 12.
        for (x = foot_x, y = foot_y)
            translate([x, y, cmi_z1]) m4_bolt_hole(cmi_cov_t);
        // 12 V entry: a single grommeted hole, replacing the old side-wall raceway.
        // The feed comes down from the battery directly above.
        translate([cmi_grom_x, cmi_grom_y, cmi_z1 - 1])
            cylinder(d = cmi_grom, h = cmi_cov_t + 2);

    }
}

module compute_box_inline() {
    difference() {
        translate([cmi_x0, cmi_y0, cmi_z0])
            rbox(cmi_w, cmi_d, cmi_z1 - cmi_z0, 2);
        // Tray -> cover screws: clearance straight through the side walls, so they
        // are driven from OUTSIDE the closed box.
        for (w = cmi_lug_w, y = cmi_lug_ys)
            translate([w[0] - w[1] * (cmi_wall + 1), y, cmi_lug_ax])
                rotate([0, w[1] * 90, 0])
                    cylinder(d = m3_clear, h = cmi_wall + 2);
        // Lower half of each converter insert pocket.  The pad is added after this
        // difference, so its own local cut can only reach the pad -- the 2 mm that
        // belongs in the floor has to come out here or the pocket ends up 3 mm deep
        // against a 5 mm insert.
        for (dx = [0, cmi_conv_dy])
            translate([cmi_conv[0] + (cmi_conv[2] - cmi_conv_dy)/2 + dx,
                       cmi_conv[1] + cmi_conv_dx,
                       cmi_z0 + cmi_floor + cmi_conv_pad_h - m3_ins_h])
                cylinder(d = m3_ins_d, h = m3_ins_h + 0.01);
        // Plain cavity -- no raceway block to keep out of it any more, so the whole
        // interior is usable.
        translate([cmi_x0 + cmi_wall, cmi_y0 + cmi_wall, cmi_z0 + cmi_floor])
            rbox(cmi_w - 2*cmi_wall, cmi_d - 2*cmi_wall,
                 cmi_z1 - cmi_z0 - cmi_floor + 1, 1.5);

    }
    // Converter hold-down: blind pads, so nothing pierces the ground face.  Added
    // after the cavity is cut or it would eat them.
    for (dx = [0, cmi_conv_dy])
        translate([cmi_conv[0] + (cmi_conv[2] - cmi_conv_dy)/2 + dx,
                   cmi_conv[1] + cmi_conv_dx, cmi_z0 + cmi_floor])
            difference() {
                cylinder(d = cmi_conv_pad_d, h = cmi_conv_pad_h);
                translate([0, 0, cmi_conv_pad_h - m3_ins_h])
                    cylinder(d = m3_ins_d, h = m3_ins_h + 0.01);
            }

    // SBC standoffs -- 58.75 across X, 49.5 in Y, following the board
    for (dx = [-sbc_hx/2, sbc_hx/2], dy = [-sbc_hy/2, sbc_hy/2])
        translate([cmi_sbc[0] + cmi_sbc[2]/2 + dx, cmi_sbc[1] + cmi_sbc[3]/2 + dy,
                   cmi_z0 + cmi_floor - 1])
            difference() {
                cylinder(d = 8, h = cmi_stand + 1);
                translate([0, 0, cmi_stand + 1 - sbc_ins_h])
                    cylinder(d = m3_ins_d, h = sbc_ins_h + 0.1);
            }
}

// =============================================================================
//  PART 11d -- compute_box_front_slim
// -----------------------------------------------------------------------------
//  A stripped variant carrying ONLY the La Frite and its converter.  Nothing is
//  shared with `compute_box_front` except the rail bolt pattern and the board's
//  own numbers, so the two can diverge freely and neither file overwrites the
//  other.
//
//  The one idea that makes it flatter: the converter stands against the BACK WALL
//  instead of lying on the floor.  On the floor it consumed 35 mm of depth and
//  forced the box to 40; on the wall it consumes 15, and the 35 becomes height --
//  which this variant has to spare, because the fob, PTT board and GPS module are
//  all gone.  Depth drops 40 -> 32, and the 10 mm gap under the board becomes the
//  wiring channel from the converter up to the board.
//
//  Consequences worth stating, because they are not obvious:
//    * The switch bezel had to ROTATE 90 degrees.  At 32 mm along the depth it no
//      longer fits a 30 mm box; across the width it does.
//    * The converter stands 5 mm off the wall on two posts rather than flat
//      against it, so the wiring can pass behind it as well as under the board.
//    * The power grommet moved ABOVE the converter, into the under-board channel.
//      On the floor variant it entered behind the converter; here that would put
//      the lead straight into the converter's back.
// =============================================================================
cmf2_x     = 72;     // width unchanged -- set by the rail, not the contents
cmf2_y     = 32;     // 32, not 30: the taller standoff needs the extra depth.
                     //   10 + 1.6 board + 15 of connectors = 26.6 off the wall,
                     //   against 29 interior.
cmf2_z     = 160;    // unchanged, so the M4 rows still land on the rail
cmf2_boss  = 8;      // local back-wall thickness at the M4 bolts
sbc2_stand = sbc_stand_hi;   // shared with the deep box

//  Converter FLUSH against the back wall, held by two M3 through-holes rather
//  than standing on posts.  The heads are countersunk into the OUTER face: the
//  bottom-front crossbeam lies directly behind this wall over box-local Z -4..20,
//  so a proud screw head there would stop the box seating on the beam.
cmf2_buck_dx = 54;        // its tab holes, as measured
cmf2_buck_bz = 16.5;      // 13.5 from its lower edge, which now runs across
cmf2_buck_cs = 6.0;       // countersink diameter at the outer face
cmf2_sbc_z   = [55, 119]; // the board, moved up 13 mm to open the 12 V band
                          //   it: the switch takes X 4..36, the dongle X 40..64

//  12 V entry in the BACK WALL, right of centre, in the band between the
//  converter and the board.  That band only exists because the board was moved UP
//  13 mm: at its old height there was nowhere at all for this hole -- Z 20 and
//  below has the crossbeam behind it, Z 3..38 is covered by the flush converter,
//  Z 38..42 was a 4 mm gap, and above that is the board.  Ø12 at Z 46 spans
//  40..52: clear of the beam at 20, the converter at 38 and the board at 55.
cmf2_grom_x  = 56;
cmf2_grom_z  = 46;

//  Switch bezel ROTATED 90 deg (32 across X, 20 through the depth) and sitting on
//  the RIGHT, over the 12 V entry at X 56.  The switch breaks the 12 V line, so it
//  belongs at that end: run and switch stay on one side, and the 5 V output leaves
//  from the other.  It was briefly on the left, which put a switched 12 V pair
//  straight across the 5 V side of the box.
//  It does NOT require the M4 holes to move: the bezel sits at Y -9..-29 and the
//  pads stop at Y -8, so they are on opposite faces and miss entirely.
cmf2_sw_x    = 52;        // bezel X 36..68, 4 mm off the outer edge
cmf2_sw_y    = -16;       // centred in the depth, on the same line as the USB
                          //   hole: interior is Y -3..-29, so -16 is the middle.
                          //   The 20 mm bezel then spans Y -6..-26, clearing the
                          //   back wall by 3 mm and the front opening by 3.
//  USB bulkhead, LEFT end of the top wall, opposite the switch.  Same D-form as
//  the deep box -- Ø12 with the top and bottom flattened to 11 across -- which is
//  the connector's own anti-rotation shape.  It replaces an assumed 14 x 8 slot
//  with two M3 at 24 mm centres, which was the wrong shape for this connector and
//  needed two fixings this one does not.
//
//  Losing those fixings is what let it centre properly.  The 24 mm screw span made
//  the hardware 30 mm wide and left 1 mm to the switch bezel; a bare Ø12 leaves the
//  left half of the wall almost empty by comparison.
cmf2_usb_d    = cmf_usb_d;      // 12, shared with the deep box
cmf2_usb_flat = cmf_usb_flat;   // 11
cmf2_usb_x    = 20;
cmf2_usb_y    = -16;      // centred in the depth: interior Y -3..-29

module compute_box_front_slim() {
    bz  = [cmf2_z - 18, cmf2_z - 8];             // 142 / 152, the rail rows
    bx  = [cmf2_x/2 - cmf_bolt/2, cmf2_x/2 + cmf_bolt/2];
    scz = (cmf2_sbc_z[0] + cmf2_sbc_z[1]) / 2;   // 87
    difference() {
        union() {
            translate([0, -cm_wall, 0]) rbox(cmf2_x, cm_wall, cmf2_z, 1.5);
            for (wx = [0, cmf2_x - cm_wall])
                translate([wx, -cmf2_y, 0]) rbox(cm_wall, cmf2_y, cmf2_z, 1.5);
            translate([0, -cmf2_y, 0]) rbox(cmf2_x, cmf2_y, cm_wall, 1.5);
            translate([0, -cmf2_y, cmf2_z - cm_wall])
                rbox(cmf2_x, cmf2_y, cm_wall, 1.5);
            // M4 pads, as on the deep variant
            for (x = bx)
                translate([x - 8.5, -cmf2_boss, bz[0] - 8.5])
                    rbox(17, cmf2_boss, bz[1] - bz[0] + 16, 1.5);
            // SBC standoffs, taller here to clear the DC wiring underneath
            translate([cmf2_x/2, -cm_wall, scz])
                rotate([90, 0, 0]) rotate([0, 0, 90]) sbc_pads(sbc2_stand);
        }
        translate([cmf2_x/2, -cm_wall, scz])
            rotate([90, 0, 0]) rotate([0, 0, 90]) sbc_pad_pockets(sbc2_stand);
        // Converter hold-down: M3 clearance straight through the back wall, heads
        // countersunk flush in the OUTER face so the box still seats on the beam.
        for (dx = [-cmf2_buck_dx/2, cmf2_buck_dx/2]) {
            translate([cmf2_x/2 + dx, -cm_wall - 1, cmf2_buck_bz]) rotate([-90, 0, 0])
                cylinder(d = m3_clear, h = cm_wall + 2);
            translate([cmf2_x/2 + dx, 0.01, cmf2_buck_bz]) rotate([90, 0, 0])
                cylinder(d1 = cmf2_buck_cs, d2 = m3_clear, h = 1.6);
        }
        // M4 into the crossbeam's accessory columns
        for (x = bx, z = bz)
            translate([x, -cmf2_boss, z]) rotate([-90, 0, 0]) m4_bolt_hole(cmf2_boss);
        // 12 V in through the BACK WALL, right of centre, between converter and board
        translate([cmf2_grom_x, -cm_wall - 1, cmf2_grom_z]) rotate([-90, 0, 0])
            cylinder(d = cmf_grom, h = cm_wall + 2);
        // power switch, top wall, left side
        translate([cmf2_sw_x, cmf2_sw_y, cmf2_z - cm_wall - 1])
            cylinder(d = cmf_sw_d, h = cm_wall + 2);
        // cable-tie mounts up both side walls
        for (wx = [0, cmf2_x - cm_wall], tz = cmf_tie_z)
            translate([wx, -cmf2_y/2, tz]) cm_tie_mount(cm_wall);
        // plus two high ones on the USB side -- MIRRORED from the deep box, because
        // this variant's switch sits on the right, so here the LEFT wall is clear
        for (tz = cmf_tie_z_hi)
            translate([0, -cmf2_y/2, tz]) cm_tie_mount(cm_wall);
        // USB bulkhead: Ø12 flattened top and bottom to 11 across, no fixings
        translate([cmf2_usb_x, cmf2_usb_y, cmf2_z - cm_wall - 1])
            intersection() {
                cylinder(d = cmf2_usb_d, h = cm_wall + 2);
                translate([-cmf2_usb_d, -cmf2_usb_flat/2, -1])
                    cube([2*cmf2_usb_d, cmf2_usb_flat, cm_wall + 4]);
            }
    }
}

//  Velcro-closed cover for the slim box: panel plus locating rim, no fixings.
module compute_box_front_slim_cover() {
    union() {
        rbox(cmf2_x, cmf2_z, cmf_cov_t, 1.4);
        translate([cm_wall, cm_wall, cmf_cov_t - 1]) difference() {
            rbox(cmf2_x - 2*cm_wall - 0.4, cmf2_z - 2*cm_wall - 0.4,
                 cmf_cov_lip + 1, 0.8);
            translate([4, 4, -1])
                rbox(cmf2_x - 2*cm_wall - 8.4, cmf2_z - 2*cm_wall - 8.4,
                     cmf_cov_lip + 3, 0.8);
        }
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
                               //   switch by 2 mm -- see below.
                               //   the number that fills the top bay: it puts the
                               //   switch body at Z 127..157, leaving only 24 mm
                               //   of height beneath it.  A PTT board taller than
                               //   ~23 mm will not pass under, and there is
                               //   nowhere else 40 mm wide for it to go.




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

    color("#c9a227") translate([bb_beam_x, beam_y_f, z_bb0 - ex])
        crossbeam(rows = bb_rows, span = bb_span, x0 = bb_beam_x);
    color("#c9a227") translate([bb_beam_x, beam_y_b, z_bb0 - ex])
        crossbeam(rows = bb_rows, span = bb_span, x0 = bb_beam_x);
    color("#c9a227") translate([panel_t, beam_y_f, z_tb0 + ex])
        crossbeam(front_cols = front_cols);
    color("#c9a227") translate([panel_t, beam_y_b, z_tb0 + ex]) crossbeam();


    for (bx = [ant_x_l, ant_x_r])
        color("#5f9e6e") translate([bx, -ex, z_tb0]) antenna_mount_fitted();

    // The base plate is gone -- the battery box's tabs are the bottom joint now.
    // compute_box_inline still bolts up into the beams' underside inserts, but it
    // cannot brace them: with the bottom beams short by tab_t at each end it needs
    // tabs of its own, which is the next piece of this rework.
    if (show_battery_box)
        color("#6d7f96") translate([0, 0, -2 * ex]) battery_box();

    // the compute module hangs off the battery box's feet, at the bottom of the stack
    if (show_inline_box) {
        color("#8a8f98") translate([0, 0, -3 * ex]) compute_box_inline_cover();
        color("#8a8f98") translate([0, 0, -4 * ex]) compute_box_inline();
    }

    if (show_radio) radio_proxy();
}

// =============================================================================
//  OUTPUT  (each single-part case is laid out in its recommended print pose)
// =============================================================================
if      (part == "assembly") frame(0);
else if (part == "exploded") frame(26);

// Plan section through the upper shared-bolt row.  Cut at Z 168..176 so the slab
// passes through the top crossbeams, the panel pocket and the handle -- the one
// view that actually shows handle / pocket / panel / beam stacked up.

// flat on the bed, INNER face down: 175 x 70 x 9.  This way the Ø26.468 M5
// recess and the six crossbeam counterbores all open upward as plain pockets.
// The integral handle costs nothing in the print: the arch is in the plate's own
// plane and the grip aperture is a through-hole, so there is still nothing to
// bridge and no overhang anywhere.
// Outer-face-down would instead bridge a Ø26.5 ceiling directly under the
// 3.5 mm ligament that carries the radio's entire weight.
else if (part == "side_panel")
    translate([0, 0, panel_t]) rotate([0, 90, 0])
        translate([0, 0, -panel_z0]) side_panel();

// long axis on the bed, 24 mm tall: end and front-face inserts are both in-plane
else if (part == "crossbeam_top_front_dual")   crossbeam(front_cols = dual_cols);
else if (part == "crossbeam_top_front_triple") crossbeam(front_cols = triple_cols);
else if (part == "crossbeam_top_front_grid")   crossbeam(front_cols = grid_cols);
else if (part == "crossbeam_top_back")     crossbeam();
else if (part == "crossbeam_bottom_front")
    crossbeam(rows = bb_rows, span = bb_span, x0 = bb_beam_x);
// Same beam with a single row of accessory columns in its front face, so a tall
// front module (the compute box) bolts at the bottom as well as the top.  ONE
// row, not two: this beam's underside already carries the base-plate inserts
// over beam-local Z 0..9, and a second row at 6 would run straight into them.
// A row at 16 leaves 4.15 mm between the two sets of pockets.
else if (part == "crossbeam_bottom_front_rail")
    crossbeam(front_cols = grid_cols, rows = bb_rows,
              span = bb_span, x0 = bb_beam_x);
else if (part == "crossbeam_bottom_back")
    crossbeam(rows = bb_rows, span = bb_span, x0 = bb_beam_x);

// The handle is integral to side_panel (§2.6).  handle(), handle_profile() and the
// microphone-bracket modules have been removed; handle_outer() stays because
// panel_profile() builds the arch silhouette from it.

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
// open face up: the cavity mouth becomes the top, so the floor is the bed
// face and nothing overhangs
// BACK WALL DOWN.  Floor-down would leave the two top flanges cantilevering
// 19.5 mm along the whole length of each end wall.  Stood on its back the
// flanges become vertical ribs growing off the back wall, supported the whole
// way, and the open front simply faces up.
// Tray: feet down, open side up.  NOT self-supporting -- see below.
//
// This is the ONE part on the frame that needs supports.  The four Ø16 feet are
// the first 8 mm; the floor then appears all at once above them.  Sectioned:
// 702 mm2 at Z 7.6 (four feet), 13688 mm2 at Z 8.4 -- about 13000 mm2 of floor
// arriving in mid-air, which is the base plate's old failure mode reintroduced.
// The base plate escapes it by printing upside down, feet UP; the tray cannot,
// because inverting it turns the 4 mm floor into a 137 x 94 ceiling and hangs the
// SBC standoffs off it.
//
// Support under the floor for the first 8 mm is the workaround.  The fix is to
// move the feet INSIDE as bosses rising off the floor, leaving a flat underside:
// the part then prints straight onto the bed, the battery box bolts flat against
// it, and the stack loses 8 mm of height.  Not done yet -- it costs cavity space
// at the four foot positions.
else if (part == "compute_box_inline")
    translate([-cmi_x0, -cmi_y0, -cmi_z0]) compute_box_inline();
// Cover: flat, bolt counterbores opening upward.
// TOP FACE DOWN.  The lugs hang below the plate in use, so with the plate the right
// way up they would print as a 143 x 100 ceiling standing on six blocks.  Inverted,
// the face that meets the battery box's feet is the bed face and the lugs rise as
// plain vertical blocks; the M4 counterbores then open upward too.
else if (part == "compute_box_inline_cover")
    translate([-cmi_x0, cmi_y0 + cmi_d, cmi_top]) rotate([180, 0, 0])
        compute_box_inline_cover();
else if (part == "compute_box_front_slim")
    rotate([-90, 0, 0]) compute_box_front_slim();
else if (part == "compute_box_front_slim_cover") compute_box_front_slim_cover();
else if (part == "battery_box")
    translate([-bb_x0, -(bb_z0 - foot_h), frame_d]) rotate([-90, 0, 0]) battery_box();
