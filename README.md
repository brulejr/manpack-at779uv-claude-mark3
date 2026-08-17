# Modular manpack internal frame — Retevis RT-95 / AnyTone AT-779UV

This is a clean-room decomposition of the single-piece reference STL from
[RT-95 Manpack Rails and BNC bulkhead antenna mount](https://makerworld.com/en/models/1117937-rt-95-manpack-rails-and-bnc-bulkhead-antenna-mount?from=search#profileId-1115768) with the following notable changes:

- Separated into printable modules — **17 STLs**, counting alternates — each of
  which fits a Prusa Mini (180 × 180 mm bed).
- Every module-to-module joint uses stainless M4 socket-cap bolts into brass heat-set inserts.
  M3 appears only where an off-the-shelf part dictates it: the SBC and covers in
  the compute boxes.
- Radio mounts use stainless M5 bolts or factory thumb screws.
- The carrying handles are **integral to the side panels** (§2.6) — one part per
  side, no lap joint, no separate handle print.
- The battery box joins the frame on **tabs through the bottom crossbeam bolts**
  (§2.9) — no base plate, no feet, and it is a structural member rather than an
  accessory.

![assembly](img/asm_iso.png)

The battery box is not sitting under a base plate — **there is no base plate.** Its
four tabs stand in the ends of the two bottom crossbeams and take the same bolts
that hold the frame together (§2.9), which is why those beams are visibly shorter
than the top pair.

Key files and directories

- Source: `cad/manpack_frame.scad`
- Meshes: `stl/`
- Renders: `img/`

---

## 1. What the reference STL actually is

The reference was measured directly (voxel probing at 1 mm, exact plane
extraction, and 2D section polygons) rather than eyeballed. It is a single
watertight body, **140.75 × 85.00 × 228.00 mm**, 226.9 cm³:

| Feature           | Measured geometry                                                                                                                                                                                                                               |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Side rails ×2     | flat plates **8.25 mm** thick, 60 mm deep, **228 mm** tall                                                                                                                                                                                      |
| Inner clear span  | **124.25 mm** (this is the radio width datum)                                                                                                                                                                                                   |
| Radio mount       | **one Ø5.000 through-hole per rail**, at the radio bay's exact centre in both Y and Z, with a **Ø26.468 × 5.5 mm** flat-bottomed recess on the outer face                                                                                       |
| Crossbeams ×2     | **7 (deep) × 4 (tall) mm**, back face only, at Z 45.365–49.365 and Z 191.999–195.999, spanning the full 124.25 mm                                                                                                                               |
| Back stiffener ×2 | 4 mm fin at Y 73–77, inboard of each rail, tying the two beams                                                                                                                                                                                  |
| Antenna ears ×2   | 3.75 mm pad, **Ø12.468** hole, 25 mm forward cantilever, hole 12.66 mm back from the pad tip and 11.375 mm inboard of the rail's inner face; diagonal gusset **confined to the 8.25 mm rail plane**; the two ears tied by a 4.78 × 3.75 mm rail |
| Handles           | integral loop in the top of each rail: **33.75 × 18.5 mm** hand aperture, **11.5 mm** grip bar                                                                                                                                                  |
| Feet              | integral bottom arch: 40 × 40 mm aperture, 3.19 mm ground pad                                                                                                                                                                                   |

**228 mm tall is why it cannot print on a Mini.** A 60 × 228 rectangle will not
fit a 180 × 180 square at any rotation ((228 + 60)/√2 = 203.6 > 180).

Two measurements drove real design decisions and are worth calling out:

- The radio mount is a **single M5 bolt per side**, dead centre of the bay. That
  is the standard mobile-radio trunnion mount — the radio hangs on its own
  threaded side holes. It is reproduced exactly.
- The antenna gusset lives **inside the rail plane** (X 0–8.25), which is
  precisely what leaves the bore under the Ø12.468 hole clear. At X ≥ 9 there is
  only the 3.75 mm pad. Getting this wrong blocks the antenna shank.

---

## 2. Part breakdown

| #   | Part                       | Qty   | Print size (mm)   | Solid vol | Inserts |
| --- | -------------------------- | ----- | ----------------- | --------- | ------- |
| 1   | `side_panel`               | 2     | 175 × 70 × 9      | 68.8 cm³  | —       |
| 2a  | `crossbeam_top_front_dual` | 1\*\* | 124.25 × 16 × 24  | 44.5 cm³  | 12      |
| 2b  | `crossbeam_top_front_triple` | 1\*\* | 124.25 × 16 × 24  | 43.5 cm³  | 16      |
| 2c  | `crossbeam_top_front_grid` | 1\*\* | 124.25 × 16 × 24  | 43.1 cm³  | 14      |
| 3   | `crossbeam_top_back`       | 1     | 124.25 × 16 × 24  | 46.3 cm³  | 4       |
| 4a  | `crossbeam_bottom_front`   | 1\*\*\*\* | **106.25** × 16 × 24  | 39.0 cm³  | 6       |
| 4b  | `crossbeam_bottom_front_rail` | 1\*\*\*\* | **106.25** × 16 × 24  | 35.8 cm³  | 13      |
| 5   | `crossbeam_bottom_back`    | 1     | **106.25** × 16 × 24  | 39.0 cm³  | 6       |
| ~~6~~ | ~~`handle`~~             | —     | *integral to the side panel* | —  | —       |
| 7   | `antenna_mount_bnc`        | 2\*   | 35 × 24 × 33      | 10.9 cm³  | —       |
| 8   | `antenna_mount_so239`      | 2\*   | 35 × 24 × 38      | 11.6 cm³  | —       |
| ~~9~~ | ~~`base_plate`~~         | —     | *superseded by the battery box's tabs (§2.9)* | — | — |
| 10  | `battery_box`              | **1, not optional** | 143 × **75.8** × 94.8 | 111.3 cm³ | —       |
| 11a | `compute_box_inline`       | 1\*\*\* | 143 × 100 × 47 | 116.7 cm³ | 4 + 4 M3 |
| 11f | `compute_box_inline_cover` | 1\*\*\* | 143 × 100 × 8  | 104.7 cm³ | —       |
| 11b | `compute_box_front`      | 1\*\*\* | 72 × 160 × 40     | 84.5 cm³  | 4 M3    |
| 11c | `compute_box_front_cover`| 1\*\*\* | 72 × 160 × 5      | 36.6 cm³  | —       |
| 11d | `compute_box_front_slim` | 1\*\*\* | 72 × 160 × 32     | 73.9 cm³  | 4 M3    |
| 11e | `compute_box_front_slim_cover` | 1\*\*\* | 72 × 160 × 5 | 37.1 cm³  | —       |

\*\* Parts 2a–2c are alternatives — the three top-front layouts (§2.11). Print one.
`_dual` is the original and is bit-identical to it, so an existing beam still fits.

\* Parts 7 and 8 are alternatives — print **two of whichever connector you use**,
not both. They share an identical leg, rib and bolt pattern, so they are
interchangeable on the same crossbeam without touching anything else.

\*\*\* Parts 11a, 11b and 11d are the three compute-module variants (§2.12) — pick
one, or none. 11c, 11e and 11f are the covers for 11b, 11d and 11a respectively,
and are not optional if you fit the box they belong to.

**The battery box is now a structural member, not an accessory.** Its tabs are
what join the bottom crossbeams to the side panels (§2.9); without it the beams
stop 9 mm short of each panel and the frame has no bottom bracing. It cannot be
left off, and it cannot be removed in the field without opening the frame up.

\*\*\*\* Parts 4a and 4b are alternatives. `_rail` adds a row of accessory columns to
the bottom beam's front face, needed only if you fit `compute_box_front`. The
plain one is bit-identical to the beam already printed.

#### Which variants do I actually print?

Five of the entries above are alternates, not additions. The minimum working
frame is **11 parts** — and the battery box is one of them, because its tabs are
the bottom joint (§2.9). Everything else is opt-in.

| Choose | Options | Pick this if… |
| ------ | ------- | ------------- |
| Top-front beam | `_dual` / `_triple` / `_grid` | `_dual` if you only want two antenna mounts and already own the printed beam — it is bit-identical. `_grid` if you want the accessory rail. `_triple` for three stations. |
| Bottom-front beam | plain / `_rail` | `_rail` **only** if fitting `compute_box_front`; otherwise the plain one, which is bit-identical to the beam already printed. |
| Handles | — | No choice: the handle is integral to the side panel (§2.6). |
| Antenna mounts ×2 | `_bnc` / `_so239` | Two of whichever connector you use — never one of each. Same leg and bolt pattern, so you can swap later. |
| Compute module | `_front` / `_front_slim` / none | Alternatives to each other; each needs its own cover, and both need the `_rail` bottom beam. **`_inline` is not currently buildable** — the tab joint shortened the bottom beams and it has no tabs yet (§8). Most builds need none of them. |

Largest part is the side panel at 175 mm — **5 mm of bed margin**, the tightest
in the project. All meshes verified
watertight, single-shell, and bed-legal.

Solid volume is 946 cm³ for one of each of the seventeen live part files. A full
**11-piece** build (BNC mounts, battery box, no compute module) is **438 cm³** with
the grid beam, 438 with the triple, 439 with the dual; add 121 cm³ for the front
compute box with its cover.

That is **119 cm³ lighter than before the tab joint** — the base plate's 113 cm³
gone outright, less the 8 cm³ the battery box put on in tabs, less 20 cm³ off the
three shortened bottom beams. It is also one part fewer and 25 mm shorter.
The handle adds nothing separately; it is part of the side panel.

Actual filament use is far lower — the beams are small enough in section that
the slicer's perimeters and infill dominate. Both large flat parts are already
windowed, so there is no easy mass left to take out.

### 1 — `side_panel` ×2

![side_panel](img/side_panel.png)

A flat plate spanning **Z 25 to 200** — the frame's side *and* its carrying
handle in one part (§2.6). It carries the ported radio mount, through-holes for the
four crossbeams, and nothing else: no feet, no antenna mount, and **no heat-set
inserts at all**. Every insert lives in the mating part, which is what keeps this a
simple flat print.

- Radio mount: **two** Ø5.000 through-holes at Y 35, each with the Ø26.468 × 5.5 mm
  outer-face recess, verbatim from the reference. **Z 98** is the ported reference
  position and suits the RT-95; **Z 129** is 31 mm higher for the AT-779UV. Both
  are set by the frame top, so they do not move if the bay height changes. Use
  whichever pair matches the radio; the unused pair is just a drain hole.
- **8 × M4 clearance holes**, heads counterbored flush in the **outer** face, into
  the four crossbeams — two rows per beam, at global Z 31.5 / 42.5 and
  162.5 / 173.5.
- **One lightening window**, `win_a` at Z 32–74, plus the grip aperture at
  Z 150–193 which absorbed the old upper window. Set `panel_windows = false` for a
  plain plate.
- No handle bolts: the handle is the same part.

### 2–5 — `crossbeam` ×4

Four beams instead of the reference's two, front and back at top and bottom,
forming a closed box. Each spans the full 124.25 mm between the panel inner
faces, with **two axial M4 inserts per end** stacked vertically so the joint
cannot rotate about a single bolt.

Extra insert faces by position:

- `crossbeam_top_front_dual` / `_triple` / `_grid` — 8, 12 or 14 inserts in the
  **front face**, the accessory stations (§2.11).
- `crossbeam_bottom_front_rail` — the same beam plus 7 accessory columns in its
  front face, for a tall front module.

  ![bottom front rail](img/crossbeam_bottom_front_rail.png)
- `crossbeam_bottom_front` / `_bottom_back` — 2 inserts each in their
  **undersides**. These served the base plate; with that gone they are retained
  only for `compute_box_inline`, which is mid-rework (§8).

### 6 — the handle, now integral to the side panel

**There is no separate handle part.** The arch is the same 9 mm plate as the panel,
continuing up past the frame top. That removes the 12 mm lap on each outer face:

| | separate handle | integral |
| --- | --- | --- |
| Assembled width | 166.25 mm | **142.25 mm** |
| Parts per side | 2 | **1** |
| M4 bolts, panels + handles | 24 | **12** |
| Handle inserts | 8 | **none** |

**The part is 175 × 70 × 9, and making it fit the bed drove one frame change.**
Panel plus handle is naturally 184 mm — Z 16 at the base plate up to Z 200 at the
grip — which fits no orientation on a 180 bed: flat 184 × 70, on edge 184 × 9,
upright it needs 184 mm of Z, and rotated flat the best case is 179.6 mm at exactly
45°, leaving 0.2 mm a side.

Neither end can give. The grip aperture floor cannot drop below the radio top at
**Z 179.5** — lower than that and your fingers are inside the radio rather than
around a bar — so the 20 mm of grip is fixed. And the panel must reach **Z 16** to
cover the bottom crossbeams and pick up their bolts.

**The 9 mm came out of the dead space under the radio instead.** Thickening the
base plate (`base_t` 8 → 17) raises the bottom crossbeams from Z 16–40 to
**Z 25–49**, and the panel starts where the beams start. `bay_h` drops 116 → 107 to
keep the top beams exactly where they were.

| | before | now |
| --- | --- | --- |
| Panel starts at | Z 16 | **Z 25** |
| Bottom beams | Z 16–40 | **Z 25–49** |
| Part height | 184 mm | **175 mm**, 5 mm of margin |
| Dead space under the radio | 38.5 mm | 29.5 mm — still room for the DC harness |

> **The base plate has since been removed entirely (§2.9), but `z_frame` stays at
> 25.** It is now a bare datum with nothing underneath it rather than a derived
> height, and that is deliberate: moving it would move the panels' bolt rows and
> force a reprint of the two slowest parts on the plate. The battery box's top face
> simply comes up to meet it.

**Nothing above the bay moves.** Frame height, top crossbeams, accessory rail,
antenna mounts, compute-box mounting and the radio's own M5 holes at Z 98 / 129 are
all exactly where they were. At the time, the only reprint was the base plate. All
four crossbeams keep their original insert rows — 22.5 / 33.5 relative to their own
bodies, landing at global 31.5 / 42.5 once raised — and the panel's holes measure
to the same figures.

While doing this the radio's mounting height was restated as *"face 0.5 mm below
the frame top"* rather than *"centred in the bay"*. Both give today's numbers, but
the old form only landed correctly by coincidence and would have moved the radio
the moment `bay_h` changed.

**The grip bar is now 7 × 9 mm rather than 7 × 12**, because it lies in the panel's
own thickness. That is a thinner edge to carry on. If it reads as uncomfortable the
fix is a local thickening at the bar only, which would cost width just at the very
top rather than down the whole side.

**The top cross piece is gone and `win_b` with it.** The grip aperture now runs
from **Z 150 to 193** as a single opening, so the band of panel that used to tie
the front and back legs together above the top crossbeam screws no longer exists —
the arch does that job. The screws never constrained it: they sit at Y 8 / 62 while
the aperture spans Y 18–52, so the two never overlapped.

**The bottom cutout matches the arch.** `win_a` runs Z 32–74, leaving a **7.00 mm**
band along the bottom edge against the arch's **7.05 mm** at its apex. It can go
that low because Y 16–54 is the gap *between* the two bottom crossbeams, so it
never opens onto a beam, and the bolt counterbores measure Y 3.95–12.05, leaving
3.95 mm to the window edge.

**Edges are rounded 2 mm on the outer face and the whole perimeter; the inner face
is left dead flat.** That split is forced: the crossbeam footprints run right out
to Y 0 and Y 70, so the face they seat on cannot be softened. Measured — the inner
face reaches Y 0.04 / 69.96 at all four bolt rows and at the top beam's upper edge.

The rounding runs over the **whole part in one operation**, not just the arch. A
first attempt filleted the arch alone and left a 2 mm ledge straight across the
part at Z 180 — exactly where a hand wraps. Continuous, the outer edge measures
Y 0.98 at Z 170 / 178 / 179 and 1.04 at Z 181: a 0.06 mm difference where there had
been 2 mm.

Above Z 180 the **inner** face is rounded as well, since no beam seats there, so
the grip is soft on both edges — the bar underside measures 193.98 at each face and
193.04 across a 5 mm flat. The radius is 2 mm rather than the old bolt-on handle's
2.5, because the bar is 9 mm thick now instead of 12.

**This part takes ~2 m 40 s to export** — two minkowski passes over a 175 mm
profile. Everything else in the project is under a second.

The arch is not the reference's squared loop — everything above the frame line was
reworked after the built pack showed the original reading as two blocky slabs.

|                    | reference / v1             | now                           |
| ------------------ | -------------------------- | ----------------------------- |
| Proud of the frame | 30 mm                      | **20 mm**                     |
| Overall height     | 78 mm                      | **68 mm**                     |
| Hand aperture      | 33.75 × 18.5               | **40 × 13**                   |
| Grip bar section   | 11.5 × 12 mm, square edges | **7 × 12 mm, fully radiused** |
| Volume             | 37.6 cm³                   | **22.6 cm³**                  |

Three changes, each aimed at a stated problem:

- **10 mm off the height.** This is the whole pack's tallest point, so it comes
  straight off the assembled envelope: 210 → **200 mm**.
- **Shoulders tapered.** Above the panel line the outline is a half-ellipse
  springing from the panel top, so the handle stops carrying its full 70 mm depth
  up to a flat square top. That is what removes the bulk near the top.
- **Everything radiused except the mating face.** The part is filleted 2.5 mm on
  every edge, then sliced back at the mating plane so the face that lands on the
  panel stays dead flat and full width. Extruding to `handle_t - fill` and
  shrinking the profile by `fill` first is what makes the sphere restore full size
  at that plane rather than doming it.

**The trade:** the aperture loses 5.5 mm of height. It is widened 33.75 → 40 mm to
claw some back, but it is now a two-finger lifting loop rather than a three-finger
grip. If that reads as too tight in the hand, `grip_ap_h` and `grip_bar_h` are the
two numbers — they sum to whatever you want proud of the frame, and the bar cannot
go below ~6 mm because the fillet construction needs the profile to survive an
`offset(-2.5)`.

**The arch is constant thickness, and that was a correction.** The first cut of
this rework gave the aperture a flat top under a curved outer arch. A flat line
under a curve necessarily pinches at the ends: the band waisted to **5.29 mm at
Y 21 and Y 49** against 7.00 mm at the apex — a 24 % notch sitting exactly where
the arch meets the shoulder. My own scan showed it and I let it pass because the
bending moment is low there, which was the wrong call: a waist at a joint is a
stress raiser whatever the nominal moment. The aperture's top now follows the
outer arch offset inward by `grip_bar_h`, so the band holds 7.0–7.25 mm across the
span and _grows_ to 8.25 mm into the shoulders.

| at the arch/shoulder joint       | waisted  | constant band |
| -------------------------------- | -------- | ------------- |
| minimum depth                    | 5.00 mm  | **7.00 mm**   |
| section modulus                  | 46.4 mm³ | **94.3 mm³**  |
| stress, one-handed 6× drop-catch | 7.06 MPa | **3.47 MPa**  |
| safety factor (PLA)              | 7.1      | **14.4**      |



#### 2.6.1 — microphone bracket: removed for now

The AT-779UV's own bracket used to mount to a `handle_mic` variant of the bolt-on
handle. With the handle now integral to the side panel that part no longer exists,
and the mic mount has been **set aside rather than redesigned** — it would now
attach to the panel itself.

The bracket's numbers are worth keeping for when it comes back: **55 H × 35 W ×
10 D mm, two M3 holes 45 mm apart vertically**, and it must sit clear of the grip
aperture, which on the unified panel is at Z 180–193.

### 7–8 — `antenna_mount_bnc` / `antenna_mount_so239`

| BNC | SO-239 |
| --- | ------ |
| ![antenna_mount_bnc](img/antenna_mount_bnc.png) | ![antenna_mount_so239](img/antenna_mount_so239.png) |

The reference ear, made modular and offered in two connector variants. Both share
an identical leg, gusset ribs and M4 bolt pattern, so either bolts to the same
inserts in the top-front crossbeam — you can swap connector type later without
reprinting anything else.

|                       | `antenna_mount_bnc`     | `antenna_mount_so239`                      |
| --------------------- | ----------------------- | ------------------------------------------ |
| Connector             | BNC bulkhead            | SO-239 / UHF female, 4-hole flange         |
| Bore                  | **Ø12.468 mm** [PORTED] | **Ø15.88 mm** (0.625")                     |
| Flange screws         | —                       | 4 × Ø3.4 on a **17.98 mm** square (0.708") |
| Forward reach         | 25 mm [PORTED]          | 30 mm                                      |
| Bore setback from tip | 12.66 mm [PORTED]       | 17 mm                                      |
| Print size            | 35 × 24 × 33 mm         | 35 × 24 × 38 mm                            |

The BNC variant is the reference connector carried over verbatim — the reference
STL is itself titled a _BNC bulkhead_ antenna mount, which is what the Ø12.468
bore is for. The SO-239 variant reaches 30 mm rather than 25 mm and sets its bore
17 mm back from the tip; both were needed so the rear pair of flange screws clears
the bracket's own leg and the front pair keeps material at the pad tip.

**Both variants are a single symmetric part used twice.** An earlier revision
needed a mirrored left/right pair because the bolt columns were offset to dodge
the crossbeam's end-insert pockets. Insetting the whole bracket 6 mm from the
panel inner face solves that instead, which lets the bolts sit symmetrically
between the ribs and removes the handedness.

Verified: bore clear below each pad for the connector body, all four flange-screw
nut positions clear, and zero enclosed voids in either part.

#### Rework history (v2)

The first version of this bracket had three defects, all found on a printed part:

1. **One entire bolt column was unusable.** The ribs were 8 mm thick at the
   bracket edges and the bolt columns sat at 14 and 30 mm across a 35 mm width —
   so the 30 mm column landed inside the right-hand rib. Worse than overlapping:
   because the rib spans the full pad depth, up to **19.75 mm of solid rib sat in
   front of the counterbore mouth**, sealing both holes into enclosed internal
   voids with no tool access. The printed part showed them as blind dimples where
   the slicer had bridged over a sealed cavity.
2. **The ribs were too wide**, leaving no clear span to put the bolts in.
3. **The ribs were not actually joined to the pad.** The rib profile stopped
   exactly at the pad's underside, so the two shared a plane and nothing more —
   zero volumetric overlap. Combined with the fillet on the pad's edge, that left
   a real groove along the top of each rib, visible on the print.

Fixes: ribs thinned 8 → **5 mm**, bolts moved to **10.5 / 24.5 mm** in the open
span between them, the whole bracket inset 6 mm so those symmetric columns still
clear the crossbeam's end inserts, and the rib profile carried up through the
pad's full thickness so it merges rather than touches. Consequence: antenna bore
spacing drops from 89.25 mm to **77.25 mm**.

### 9 — `base_plate` — SUPERSEDED

> **This part is no longer in the assembly.** The bottom joint is now the battery
> box's tabs (below), which do the plate's job without a plate. The module and its
> `part="base_plate"` export are kept for the moment so the old arrangement can
> still be built, but `frame()` no longer draws it and no build needs it.

![base_plate](img/base_plate.png)

It was the modular bottom interface: bolted up into the two bottom crossbeams on
four M4 bolts, with **four bosses that were simultaneously the frame's feet and
the M4 attachment grid** that further modules bolted up into.

#### Why it went

The plate cost a whole part, 113 cm³ and 25 mm of height to do one thing — get
from the bottom crossbeams to a module underneath. **The tabs do it with no part
at all.** The battery box grows two tabs per side that stand in the space the
beams' ends used to occupy, immediately inboard of each side panel, and the same
bolts that hold the frame together now pass through them:

```
panel  |  tab  |            beam            |  tab  |  panel
X 0..9 | 9..18 |        18 .. 124.25        |  ..133.25  ..142.25
       └─ M4 × 20 ─────────────► insert in the beam end
```

Each bottom beam therefore loses **2 × 9 = 18 mm**, going from 124.25 to
**106.25 mm**. The eight bolts on the two bottom rows (Z 31.5 and 42.5) grow from
M4 × 12 to **M4 × 20**.

**What this buys:** the base plate disappears, the battery box loses its feet and
gains a flat bottom, and the stack loses 25 mm of height. The module is captured
by the frame's own fixings rather than hanging off a plate on four more.

**What it costs, and it is not small: the frame no longer closes without the
battery box.** The bottom beams cannot reach the panels on their own. The box is a
structural member now — it carries the bottom bracing — so it cannot be left off,
and taking it out in the field opens the bottom of the frame.

**The frame's own geometry is untouched.** `z_frame` stays at 25 as a pure datum
even though nothing sits below it any more, so the panels' bolt rows do not move
and **neither side panel needs reprinting** — the two slowest parts on the plate.
Only the three bottom beams and the battery box change.

**`compute_box_inline` is an alternative to this part, not an addition** (§12) —
that box's cover does the bolting-up and its tray presents the same four feet, so a
build with the inline module does not print a base plate at all.

**It is a ring, not a plate.** All that remains is the perimeter backing the two
side panels (X 0–9 and 133.25–142.25) and the two bottom crossbeams, widened front
and back to carry the feet. The centre is a **120.25 × 30 mm stadium opening**,
which also serves as the battery lead's pass-through — it spans the same 30 mm of
depth the old 36 × 26 cable slot did and the entire width, so it passes anything
that slot did, and the separate slot is gone.

The opening cannot follow the beam lines exactly. The Ø16 feet at Y 12 / 58 reach
4 mm past them, and **corner rounding cannot rescue it**: at the ideal Y 16–54 the
largest radius that fits is 19 mm, still short of the 19.2 mm needed to clear a
foot. Counter-intuitively a _larger_ radius helps — a small corner brings the
opening nearer the foot — so the optimum is the limit case, a full stadium. At
Y 20–50 with r = 15, inset 2 mm from the panel inner faces, it leaves **2.94 mm**
of material between each foot boss and the opening edge, which the model asserts
on every render.

**Its bolt counterbores are sunk.** The plate grew from 8 to 17 mm of body when the
bay shortened to make room for the unified side panel (§2.6), which would have
needed a 20 mm shank — past the M4 × 12 the rest of the frame uses. The counterbore
now runs to `base_t − 4`, so the head sits 4 mm below the top face and an M4 × 12
still reaches 7 mm into the beam. Nothing else about the joint changed.

The 2 mm inset is deliberate. Running the opening right up to the panel line — the
literal reading of "line up with the side panels" — made the arc exactly tangent
to the panel's inner face at Y 35: zero margin at one point. Because the plate
prints upside down that face is the _first layer_, where elephant-foot
compensation enlarges a hole, so the opening would have crept ~0.2 mm under the
panel edge. The inset costs ~120 mm² of opening (3 %) and, as a bonus, improves
the foot ligament from 2.08 to 2.94 mm.

Verified after the cut: the perimeter still fully backs both side panels (100 % of
samples) and both crossbeams, the material around all four feet and all four base
bolts is intact, and the worst-case panel margin measures 1.995 mm. Opening the
centre takes **58.0 cm³** out of the plate — a solid one at the current 17 mm of
body would be 170.8 cm³ against the actual 112.8, 34 % lighter.

Its top face is deliberately left flat. An earlier revision had two raised
locating lips for the panel bottom edges; they made the part unprintable (see
§9), and since the panels are located by their 16 bolts into the crossbeams, the
lips were redundant.

### 10 — `battery_box`

![battery_box](img/battery_box.png)

An **open frame** — not a box — for a **TalentCell LF4011 12 V 6 Ah LiFePO4**
pack lying flat on its largest face (**132 × 75.8 × 37.3 mm**, measured).

**It joins the frame on four tabs**, two per side, each standing in the space a
bottom crossbeam's end used to occupy. Measured: **X 9.02–17.98 and
124.28–133.22**, **Z 25–49** flush with the beam tops, over the beams' own Y bands
of **0–16 and 54–70**.

Four tabs and not two full-depth ones, because **the radio occupies Y 17–53 at
that height** — a tab running the full depth would foul it. That is also why the
front pair cannot be made self-supporting and **print on support**: the space a
gusset would need is the radio bay. See §8 item 16 for the full reasoning and §9
for the slicer setting. They rise off the top
flange, which already reaches 19.5 mm inboard of each end wall (to X 23.125 and
119.5), so both footprints sit on solid material.

The eight bolts run panel → tab → beam insert: 4 mm of counterbore, 5 mm of
remaining panel, 9 mm of tab, then **6 mm of thread engagement** on an
**M4 × 20**. That is one millimetre less engagement than everywhere else on the
frame — still 1.5 × D, the normal minimum for M4 in a brass insert, and the insert
is 8 mm long. M4 × 25 is *not* an alternative: the pocket is 9 mm deep and 25 would
need 11, so it bottoms out before it clamps.

Structure: two end walls, a back wall and a floor, every one of them windowed,
plus a centre rib under the pack. The front is open so the pack slides in, and
the top is open between the flanges. **Its top face is now the frame's floor** —
the panels and both bottom beams land on it — which is the other job the base
plate used to do. The pack's lead goes straight up past the flange into the bay.

Retention is by geometry, not just the strap. A **top flange runs the full length
of each end wall**, reaching 19.5 mm inboard so it laps 18 mm over each of the
pack's long edges. The pack can lift 2.5 mm before it meets them. The flange runs
the full length rather than being four pads because the bolts sit 10.4 mm inboard
of the walls — too far to cantilever cleanly — and a full-width cross rail would
have been a 135 mm bridge. A hook-and-loop strap through the four slots crosses
the 13.5 mm clear zone in front of the pack and stops it sliding out.

|                  |                                                                      |
| ---------------- | -------------------------------------------------------------------- |
| Cavity           | 135 × 90.8 × 38.8 mm                                                 |
| Outer            | 143 × 94.8 × 51.8 mm, reaching 24.8 mm forward                       |
| Behind the frame | nothing — the back wall is flush with the frame back                 |
| Bolts            | 4 × M4 × 12 into the base plate feet                                 |
| Print pose       | back wall down, 143 × 59.8 mm footprint, 94.8 tall                   |
| Stacking feet    | 4 × Ø16 × 8 mm with M4 inserts, at the same X 14 / 128.25, Y 12 / 58 |
| Stack pitch      | 59.8 mm per module                                                   |

**It presents the same interface on its underside that it consumes on top.** Four
Ø16 × 8 mm feet with M4 inserts sit at the same X 14 / 128.25, Y 12 / 58, so a
further module bolts under the battery frame exactly as the battery frame bolts
under the base plate — verified by stacking a second copy at the 59.8 mm pitch
with zero interference and all four bolts clean. Cables reach a module below
through the floor windows, so no extra pass-through was needed.

The feet are plain cylinders rather than ramped. A 45° print ramp would have to
run toward +Y, which is the downward direction in the print pose, and for the
rear pair at Y 58 that would have reached Y 74 — past the back face, breaking
both the "nothing behind the wearer" rule and the print pose's bed datum. Left
unramped they cost about 18 mm² of unsupported area each, which is what any
horizontal boss costs. The floor windows were reshaped around all four pads.

Windowing still nearly halves it: 103.3 cm³ against ~190 cm³ for the equivalent
closed box.

### 11 — the top-front crossbeam: three layouts

| `_dual` | `_triple` | `_grid` |
| --- | --- | --- |
| ![dual](img/crossbeam_top_front_dual.png) | ![triple](img/crossbeam_top_front_triple.png) | ![grid](img/crossbeam_top_front_grid.png) |

All three use the **same station pattern** — a copy of the antenna mount's own
four bolts, two M4 columns 14 mm apart and two rows 10 mm apart at Z 162 / 172.
They differ only in how many stations and where, so the antenna mounts are
unchanged and interchangeable between them.

| | `_dual` | `_triple` | `_grid` |
| --- | --- | --- | --- |
| Bolt columns | 4 | 6 | **7, uniform** |
| Column spacing | 14 / 63 / 14 | 14 / 24 / 14 / 24 / 14 | **14 mm throughout** |
| Inserts | 8 | 12 | 14 |
| Mounting positions | 2 fixed | 3 fixed | **6, overlapping at 14 mm** |
| Wider bolt spans | no | no | **yes — 28, 42, 56, 70, 84 mm** |
| Outer bore spacing | 77.25 mm | 76 mm | 70 mm |
| **35 mm brackets at once** | 2 | **3** | 2 |
| Volume | 44.5 cm³ | 43.5 cm³ | 43.1 cm³ |

`_dual` is the original: one station per antenna mount, nothing else. It is
**bit-identical to the beam already printed**, so it is not a reprint.

`_triple` is the one to pick if you want **three full-width mounts at once** —
three SO-239 brackets sit side by side with a 3 mm gap, spanning X 15.625 to
126.625. It is the only layout that fits three, because its 38 mm pitch exceeds
the 35 mm bracket width while 26 mm does not.

`_grid` is a **uniform 14 mm column grid**, not a set of fixed stations. Because
the pitch equals the antenna mount's own bolt spacing, *every adjacent pair of
columns is a station* — six positions at 14 mm increments rather than a few fixed
ones. It also lets a wider accessory span three, five or all seven columns for a
28 / 56 / 84 mm bolt base, which the fixed layouts cannot offer at all: good for a
Le Frite compute box or a DC charge-port plate that wants a broad, stiff footprint.

The model asserts `grid_pitch == 2 * rail_bolt_dx`, because the grid only works as
a grid while its pitch matches the mount's bolt spacing.

An earlier revision of this layout used four fixed stations at 26 mm, which gave
columns alternating 14 / 12 mm — the stations were equally spaced but the holes
were not. Four stations *cannot* be made uniform: that needs a 28 mm pitch, which
overruns the beam's usable bolt span by 1.7 mm at each end and drives the outer
pockets into its own end inserts. Dropping to a 7-column grid fits with 5.3 mm to
spare and gives more positions, not fewer.

**Four full-width mounts are not possible on any layout.** Their bolts must lie
within X 23.85–118.40 (94.55 mm) to stay 3 mm clear of the beam's own end-insert
pockets, and four brackets packed edge to edge need 119 mm of bolt span. Shrinking
the bracket to the ≤26.85 mm that would allow it leaves 2.33 mm per gusset rib,
down from 5 mm — and those ribs carry the cantilevered pad and the antenna's
bending load.

Every layout keeps its outermost pocket at least 3 mm clear of the crossbeam's
own end-insert pockets, which occupy the first and last 9 mm of the span; the
model asserts it. `_dual` and `_triple` have ~5.3 mm of material there, `_grid`
5.3 mm.

**What can coexist on `_grid`.** Positions run every 14 mm — 36.125, 50.125,
64.125, 78.125, 92.125, 106.125 — so what fits together depends only on how many
positions apart you go. Two accessories clash if their half-widths sum to more
than the gap:

| positions apart | gap | two 35 mm items | 35 mm + a 22 mm one | two 22 mm items |
| --- | --- | --- | --- | --- |
| 1 | 14 mm | no | no | no |
| 2 | 28 mm | no | no | **yes** |
| 3 | 42 mm | **yes** | **yes** | **yes** |
| 4–5 | 56–70 mm | **yes** | **yes** | **yes** |

The narrowest an accessory can physically be is about 22 mm — the 14 mm bolt span
plus two Ø8.2 counterbores. So in practice:

- **two** 35 mm antenna mounts, three positions apart or more (1&4 gives 42 mm,
  1&6 gives 70 mm)
- **three** minimum-width items at positions 1, 3, 5
- or a mix: an antenna at position 1 leaves 4, 5 and 6 open for anything

Four full-width mounts remain impossible on any layout — their bolts would need
119 mm of span against the 94.55 mm available. `_triple` is still the only layout
that fits three 35 mm brackets, because its 38 mm pitch exceeds the bracket width
outright.

Set `top_front` to `"dual"`, `"triple"` or `"grid"` to pick which one the assembly views build
with; it also moves the antenna brackets to that layout's outer stations.

---

### 12 — `compute_box`, three variants

| `_inline` (cover off) | `_front` (cover off) |
| --- | --- |
| ![inline](img/compute_box_inline.png) | ![front](img/compute_box_front.png) |

Carries a **Libre Computer La Frite** (AML-S805X-AC, 64 × 56 mm, M3 mounting on
**58.75 × 49.5**) with its 128 GB eMMC, plus a CM108/CM119 USB audio
fob, a PTT board and a GPS module, for onboard logging over WiFi to a tablet.

**Only the SBC and the converter get dedicated mounts**, because they are the only
two whose footprints are fixed and known. Everything else is zip-tied. Swapping a
CM108 for a CM119, or changing the PTT board entirely, costs nothing.

Neither box **has the M3 hole grid** any more. It was removed along with the back-wall
cutout: neither earned its place once the board was rotated, and the bays are big
enough that loose devices are better zip-tied than bolted to a hole that happens
to line up. Ventilation is now whatever the openings happen to give: the cover is
solid and the rim slots are gone, so the box breathes only through its cable
entries. That is fine for an idling SBC in a padded bag and should be revisited if
anything warm goes in.

**The mounting pattern is now measured, not published — and the published figure
was wrong.** M3 was confirmed early by test-fitting a bolt. The pitch was carried
as the Raspberry Pi Model A figure of 58 × 49.5 until a **printed test fit** showed
it short: with the pair nearest the converter seated, the pair at the USB end
missed by 0.5–1 mm. Calipers on the board put that dimension at **58.5–59 mm**, so
the model now uses **58.75**, the midpoint. 49.5 fitted and is unchanged.

Residual uncertainty is ±0.25 mm against roughly ±0.1 mm of slack from an M3 in the
board's ~3.2 mm hole, so **start all four screws before tightening any of them** —
the board will pull into place across four fixings but binds if one corner is fully
seated first. That is most likely what made the USB-end pair read as clearly wrong
rather than merely tight. If a later measurement lands nearer one end of the range,
`sbc_hx` is the single number to move.

This is the second assumption in the project that only a printed part could
retire — the first was the antenna bracket's sealed counterbores.

|                   | `_inline`                          | `_front`                        |
| ----------------- | ---------------------------------- | ------------------------------- |
| Mounts to         | nothing — **it is** the base plate, and the stack sits on it | the top-front crossbeam's accessory columns |
| Outer, tray       | 143 × 100 × 47 mm                  | 72 × 160 × 40 mm                |
| Outer, with cover | 143 × 100 × **55 mm**              | 72 × 160 × 43 mm (2 of the cover's 5 nests inside) |
| SBC orientation   | flat on the floor, long axis **across** the tray | flat on the back wall, **turned 90°** |
| Converter         | flat on the floor, **behind** the board | flat on the floor, below the board |
| Opens             | **upward**, cover off              | forward, cover off              |
| Cover             | `compute_box_inline_cover`, 104.7 cm³ | `compute_box_front_cover`, 36.6 cm³ |
| Volume, tray      | 116.7 cm³                          | 84.5 cm³                        |

#### 11a/11f — `compute_box_inline` and its cover

| plan (cover off) | cover |
| --- | --- |
| ![inline plan](img/compute_box_inline_plan.png) | ![inline cover](img/compute_box_inline_cover.png) |

**This part replaces `base_plate`. Do not print both.** The tray takes over the
plate's structural job — its cover is what the bottom crossbeams bolt into, and its
underside carries the same four Ø16 feet with M4 inserts that the battery box hangs
from. Everything above and below it is unchanged; the frame simply sits 30 mm
higher.

Total stacked height is **55 mm** — the constraint the whole part was designed
against — split 47 mm of tray plus an 8 mm cover:

| band | Z (frame) | height |
| ---- | --------- | ------ |
| cover | 17 … 25  | 8 mm  |
| cavity | −18 … 17 | **35 mm** |
| floor | −22 … −18 | 4 mm |
| feet  | −30 … −22 | 8 mm |

The cavity's 35 mm against 24.6 mm of contents (8 mm standoff + 1.6 board + an
assumed 15 mm of component height) leaves **10.4 mm of headroom**. That number is
only as good as the 15 mm assumption — see §8.

**Depth is 100 mm, 5.2 mm deeper than the battery box, and that 5.2 mm is what
makes the box work.** The board lies with its long axis *across* the tray, because
its connectors are on both 56 mm edges — USB one end, Ethernet/HDMI the other — and
64 of board plus 20 of clearance at each end is 104 mm against only 88.8 of depth.
Across the tray it fits in 137. That settles the board, but not the converter: put
it *beside* the board and it eats 35 mm of the X band, leaving 38 mm to split
between the two connector zones — about 19 mm each, which is not enough for a
right-angle adapter. At 100 mm deep the converter stacks **behind** the board
instead (56 + 35 = 91 against 94 of interior) and both connector zones open up to
**36.5 mm**. The cost is that the box reaches 30 mm forward of the frame rather
than 24.8.

Measured positions:

| | X | Y | note |
| --- | --- | --- | --- |
| Board | 39.125 … 103.125 | −25.75 … 30.25 | standoffs 58.75 × 49.5, 8 mm tall |
| Converter | 31.5 … 96.5 | 31.5 … 66.5 | 0.5 mm off the back wall; 16.75 mm now free to its right |
| Raceway | 117.5 … 142.625 | 33.25 … 49 | **15.75 wide**, in from the side wall |

The converter kept its old X even though the raceway left the corner beside it,
so there is now **18.0 mm of free cavity to its right** (X 96.5 to the channel wall
at 114.5). Moving it right would shorten the 12 V run; it has not been moved,
because nothing else needs that space and the position is already printed.

The board is at Y −25.75 rather than hard against the front wall at −27: at −27 the
standoff pads merged 0.75 mm *into* the wall and the board's edge sat dead flush.
The pads overhang the board by 0.75 mm at each end, so of the 3 mm of slack in this
direction 1.5 is theirs; the remaining 1.5 is split 0.5 pad-to-wall, 0.5
pad-to-converter, 0.5 converter-to-back-wall.

**The raceway comes in from the right side wall**, walled off from the electronics
cavity on its other three sides at 3 mm. The TalentCell's two leads lay into it
from the side, run inboard past the side panel, and turn up through the cover into
the frame.

**It took three tries to find the right wall to enter from, and the back wall was
the wrong one.** The history is worth keeping because it is all one lesson about
what the channel has to dodge:

1. A notch confined to Y 62–70. The back bottom crossbeam lands on the cover at
   **Y 54–70**, so it came up directly underneath the beam and dead-ended — and
   that beam's own M4 at **(107.25, 62)** sat inside its footprint.
2. Moved inboard to X 116.25–130.25 and opened through the back face. That put
   160 mm² of the floor opening straight onto the **battery foot at (128.25, 58)**
   — the boss the battery bolts up into. Nothing can pass there.
3. Squeezed between the two: the beam's M4 counterbore reaches X 111.35 and the
   foot's boss starts at 120.25, leaving 8.90 mm and a **6.90 mm** slot. Clear of
   everything and too narrow to use.

**Along the back edge there is simply no room.** The right side wall has far more:
the only obstructions are the two right-hand feet, at **Y 4–20 and Y 50–66**, with
**30 mm of clear Y between them**.

So the channel enters from the side, and its width is bounded by what it must not
touch:

| bound | set by | value |
| --- | --- | --- |
| front | the board's Y band ends at 30.25 and its connectors project in ±X across it | wall starts there |
| back | the right-back foot's boss begins at Y 50, less 1 mm | Y 49 |

That gives **Y 33.25–49, a 15.75 mm channel** — more than double the back-edge
attempt and wider than the 14 mm it started life as. All of it derived, so it
tracks `cmi_sbc` and `foot_y` if either moves.

**It also lands entirely between the bottom crossbeams** (Y 0–16 and 54–70), so
unlike every back-wall version it costs neither beam any bearing on the cover, and
it leaves the board's right connector zone untouched.

**X differs between the two parts, deliberately.** The tray's channel is open at
the box's outer side face and runs inboard to **X 117.5**, so its mouth inboard of
the side panel's inner face at 133.25 is 15.75 mm — exactly as long as the channel
is wide. The cover's aperture stops at **X 132.25, 10 mm in from the frame edge**:
the side panel lands on that face at X 133.25–142.25, so an opening that reached
the edge would undercut it for nothing. The leads lie into the tray from the side,
under the panel, and turn up through the cover inboard of it.

**The cut stops at the floor's underside** rather than running down through the
foot band as the old notch did. Below the floor the space between the feet is open
air, so there is nothing to channel through. All four feet measure intact.

Earlier versions got the walls wrong twice: the first cut went straight into the
cavity, and the block that fixed it was exactly as wide as the notch, so it had a
back wall and no sides. Both were caught by measuring the walls rather than
trusting the parameters.

**Tray-to-cover fixing is currently absent.** The six M3 pads and their inserts
have been removed: they were placed before the cover inherited the base plate's
bolt pattern and bore no relation to it. The tray presently just sits under the
cover. This is a known gap, to be settled once the cover's frame mounting is
final — see §8.

The cover carries the four M4 clearance holes for the bottom crossbeams on the base
plate's own bolt pattern, with the heads sunk to 4 mm so an **M4 × 12 still engages
7 mm** in the beam. Its cable opening is a 24 × 30 slot at X 6–30, Y 20–50, sized
to the raceway rather than the base plate's full-width stadium, and kept inside
Y 16–54 because the bottom crossbeams land on this face at Y 0–16 and Y 54–70.

**The tray is the one part on this frame that needs supports, and that is a
defect, not a choice.** It prints feet down, open side up. The four Ø16 feet are
the first 8 mm; the floor then arrives all at once above them — sectioned,
**702 mm² at Z 7.6 against 13 688 mm² at Z 8.4**, so roughly 13 000 mm² of floor
prints in mid-air. That is the base plate's old failure mode reintroduced. The
plate escapes it by printing upside down with the feet *up*; the tray cannot,
because inverting it turns the 4 mm floor into a 137 × 94 ceiling and hangs the
four SBC standoffs off it.

Support under the floor for the first 8 mm works and is cheap — it is a
non-cosmetic underside and only 8 mm tall. **The proper fix is to move the feet
inside**, as bosses rising off the floor with their insert mouths opening
downward through it: the underside goes flat, the tray prints straight onto the
bed with no supports at all, the battery box bolts flat against it, and the stack
loses 8 mm of height. The cost is cavity space at the four foot positions. **Not
done yet** — see §8.

The cover prints flat, bolt heads up, and needs nothing.

#### 11b — `compute_box_front`

**`_front`** hangs off the crossbeam, inside the 160 H × 80 W × 50 D envelope
available on the front of the frame. **Width is set by the rail, not by the
contents**: 72 mm is what leaves one antenna mount beside it with a 9.5 mm gap,
and both the board (56 across) and the converter (65) fit the 66 mm interior
without it growing. **Depth is set by the converter** — 35 mm front-to-back needs
37 of interior, so 40 outer.

**The board is turned 90°, and that turn is what makes the box work.** With the
La Frite's 58 mm hole axis vertical, the **USB edge points up toward the radio and
the power/Ethernet edge points down toward the battery** — the ports are reachable
in the orientation the box is actually used in. It also means the board needs
56 mm across instead of 64, which is what let the box narrow from 80 to 72.

Three bays, top to bottom:

| Z (box-local) | height | contents                                    |
| ------------- | ------ | ------------------------------------------- |
| 107 – 157     | 54 mm  | USB devices, plugged into the upward ports  |
| 39 – 103      | 64 mm  | the La Frite                                |
| 3 – 18        | 15 mm  | buck converter, flat on the floor           |

Standoffs measure at X 11.25 / 60.75 and Z 41.65 / 100.35 — 49.5 across,
**58.75 up**. They stand **8 mm** off the back wall with a **7.5 mm** insert
pocket — 7 mm of insert plus 0.5 mm of relief so it seats flush. Measured: pad top
at bedZ 10.95, pocket from 3.45, leaving 0.45 mm of boss and then the 3 mm back
wall behind it.

**8 mm is the minimum that houses the insert.** At 7.5 the pocket bottoms exactly
on the wall face; at 7 it starts eating the 3 mm wall. It was 10 mm, sized to give
a generous DC channel under the board — the side cable-tie mounts now carry the
long runs, so the channel only has to get power across to the board, and 8 mm
does that.

Measured clear interior, which is what the electronics actually get:

| | clear | contents | spare |
| --- | --- | --- | --- |
| Width, bottom bay | **66.05 mm** | converter 65 | **1.05 mm total — 0.5 a side** |
| Depth | **37.05 mm** | converter 35 | 2.05 mm |
| Floor to board edge | 42.00 mm | converter 15 + gap | — |
| Top bay depth | 31 mm clear of the M4 pads | — | 37 mm if a device straddles them |

**That 0.5 mm per side on the width is the tightest fit in the project.** It is a
print-tolerance judgement, not a clash: a Mini typically holds internal dimensions
within ±0.15 mm and the converter has its own tolerance, so it should go in, but
there is no room to be wrong and none for a zip tie beside it. If it binds, scrape
the wall rather than reprint.

**The board sits 5 mm lower than it first did**, which is worth understanding
because it is free height. Dropping the converter flat onto the floor freed 5 mm;
spending it on the board position rather than on the connector gap handed the 5 mm
to the USB bay, where it is scarce. A CM108/CM119 fob runs ~50–52 mm: at the old
49 mm it did not fit, at 54 it does.

Its four M4s want two accessory columns **28 mm apart** — on the `_grid` beam,
columns 85.125 and 113.125, the pair that lands inside a 72 mm box sitting to the
right of an antenna mount. The bolts land on local 8 mm pads, because a 3 mm wall
cannot hold a 4 mm counterbore.

**It bolts top and bottom.** Four M4s into the top beam at Z 162 / 172, plus two
into `crossbeam_bottom_front_rail` at Z 32, so it is tied at both ends rather than
hanging as a cantilever from the top alone.

That bottom row is a **single** row, not two. The bottom-front beam's underside
already carries the base-plate inserts over beam-local Z 0–9, and a second row at
6 would run straight into them; a row at 16 (global Z 32) leaves 4.15 mm between
the two sets of pockets and keeps all seven columns usable. It also lands 12 mm up
the box's back wall, clear of its bottom rim.

**Cable entries on `_front`.** A back-wall grommet and two top-wall bulkheads —
the floor is solid, because the converter sits on it:

| connection | route |
| --- | --- |
| DC power from the battery | **Ø12 grommet in the back wall, X 12 / Z 28** |
| Audio to/from the radio | **no entry** — the rim slot was removed |
| PTT | **no entry** — see above |
| Ethernet, HDMI | right-angle adapters inside the box — see below |
| USB (the CM108/CM119 fob) | plugs directly into the upward ports in the top bay |
| WiFi antenna | SMA bulkhead, right side wall, Y −20 / Z 118 |

**The top wall carries exactly two openings**, both on the depth centreline at
Y −20, and nothing else:

| feature | position | measured |
| --- | --- | --- |
| Missile-switch barrel | X 20 | Ø11.95 |
| USB bulkhead | X 54 | 12.00 across X, **11.05 between the flats** |

The USB hole is a **D-form** — Ø12 with the top and bottom flattened to 11 mm
across — which is the connector's own anti-rotation shape, so it needs no separate
fixings. The flats are assumed to run across the *depth*; if the connector keys the
other way it is a 90° rotation and one line.

**The switch sits on the left, over the 12 V entry at X 12**, so the switched 12 V
pair stays at that end of the box. It was briefly on the right, 46 mm from its own
supply, which put a switched pair straight across the 5 V side.

**The 30 × 14 top rim slot is gone.** It used to carry audio, PTT and a GPS lead
down from the AT-779UV's control face, which points up at Z 179.5 — but it shared
this end of the top wall with the USB hole, and two openings were doing the work of
one. Consequence worth stating plainly: **this box now has no cable entry for audio
or PTT.** The back-wall Ø12 at Z 28 is power only and sits behind the converter.
If a PTT board stays in this box, it needs an entry adding back.

**Cable-tie mounts, and the two walls differ.** Both carry five at
Z 25 / 50 / 75 / 95 / 110; the wall opposite the switch carries **two more at
Z 130 / 150**, for seven. Each is a **pair** of 8 × 3 mm slots with a **4 mm ligament**
between them: the tie goes in one slot, across the ligament on the outer face,
back in the other, then round the bundle.

On the deep box they sit **rearward of the depth centre, at Y −15**. Centred at
−20 their near slot stopped at Y −14 while the under-board channel ends at −13, so
nothing in that channel could be tied down at all; at −15 the near slot runs
Y −13 to −5 and straddles it. The slim box needs no such offset — it is shallow
enough that its centreline already reaches.

That pairing is the point. The earlier arrangement was three *single* slots per
wall, and a single slot does not retain a tie — thread one through, round the
bundle and back out the same opening, and the bight on the outside spans nothing
and pulls straight back through. They were also spaced 24 mm and then 92 mm apart,
leaving the whole middle of the box unsupported for any run along its length. Both
boxes now carry the same five mounts, verified at a 4.10 mm ligament.

**The asymmetry is the switch body.** It hangs from the panel underside at Z 155
down to **Z 125** and leaves only 1 mm of side gap beside it — so Z 130 and 150 are
worthless on the switch side, but the opposite wall has 33 mm there and keeps them.
Note that underside is at 155, not 157: the 2 mm bezel recess pad lowered it, so
the body reaches 2 mm further down than the bare bezel depth suggests.

**Which wall is the clear one mirrors between the variants** — the deep box has its
switch on the left, so its seven-mount wall is the right (the USB / WiFi side); the
slim box has its switch on the right, so its seven-mount wall is the left.

Z 110 is separately the highest position that clears the SMA bulkhead at
Z 114.75–121.25, by 3.25 mm.

Usable side gap, band by band: 0.5 mm beside the converter (Z 3–18), full width
Z 18–39, 5 mm beside the board (Z 39–103), full width Z 103–125, then 1 mm left /
33 mm right in the switch-body band.

The cover plate's tab overhangs the top-left corner by ~7 mm and folds down the
side wall. It is carried by a **2 mm notch in the outer face of the left wall,
the same 20 mm width as the top recess** — the tab and the recessed plate are one
piece, so the two must line up or the fold sits on a step. The notch is 9 mm down
the side, giving the 7 mm fold some margin.

**SMA bulkhead in the right side wall**, Ø6.5 at Y −20 / Z 118, for a WiFi dongle
with an external antenna. It goes in the one clear band on that wall — 11.75 mm
above the board at Z 103 and 12.25 mm below the M4 pads at Z 133.5, with the
nearest zip-tie slot 22 mm away. Ø6.5 is the usual panel hole for a 1/4-36 SMA
bulkhead, but **the wall is 3 mm, at the top of what most SMA bulkheads accept** —
check the thread length before printing. A shallow outside counterbore is the fix
if it runs short.

**The switch protrudes 30 mm into the box with its cables on**, and that fills the
top bay:

```
top bay      X 3..69  x  Z 103..157     66 x 54
switch       X 4..36  x  Z 127..157     32 x 30
  region A   X 36..69 x  Z 103..157     33 x 54
  region B   X 3..36  x  Z 103..127     33 x 24   (under the switch)
```

**Centring the bezel in the depth cost 12 mm of bay width.** Turning it from
20 wide × 32 deep to 32 wide × 20 deep is what makes it sit on the centreline
rather than swallowing the whole depth — but the full-height strip beside it shrank
from 45 mm to 33 mm. The audio fob is ~52 mm and rises off the board's USB ports,
so its height forces it into that strip; at 18 mm wide it fits with 15 mm to spare.

**The GPS module no longer fits.** 18 (fob) + 25 (GPS) = 43 mm side by side against
a 33 mm strip, and its 25 mm height also exceeds the 24 mm clear under the switch.
It fitted at 45 mm and does not at 33. A PTT board still does, because it sits
below Z 127 and may run past X 36 where the switch does not reach — but the same
**~23 mm height limit** applies to anything under the switch.

**Power moved from the floor to the back wall, and its height is constrained.**
The converter now covers the floor where the grommet used to be, and entering at
the back lets the 12 V leads turn once into the frame instead of doubling back
underneath the module. But the **bottom-front crossbeam occupies global Z 16–40 =
box-local −4 to 20**, so the back wall is flat against beam material below
box-local 20 and a hole there would open into the beam, not the frame. Ø12 centred
at Z 28 spans 22–34: verified open across that band, **2 mm clear of the beam** and
5 mm below the board edge at 39.

**The converter bolts to the floor.** It is an **LY-KREE XS120503** — 12 V in,
5 V 3 A / 15 W out — with a slotted fork tab at each end, so **two** fixings, not
four. Two M3 clearance holes (Ø3.4) through the floor, **54.00 mm apart** and
**13.50 mm back from the inside face of the back wall**, both measured off the
mesh. Plain through-holes: the floor is only 3 mm, and a counterbore deep enough
for an M3 cap head would leave under 1.5 mm. Screw from underneath, or use a
countersunk screw. The tabs being slotted absorbs positional error a round hole
would not.

These replaced the zip-tie slots that used to be here. A 65 mm converter in a
66 mm interior leaves 0.5 mm a side — nothing would have passed a tie anyway.

**The datum matters:** 13.5 mm is from the **inside** face of the back wall, not
the outside. The wall is 3 mm, so reading it the other way moves the holes 3 mm.
The inside face is what the converter registers against, and the 65 mm overall is
measured across the tabs — which puts the holes 5.5 mm inboard of each end and
lands them inside the 35 mm footprint, as they must be.

**The cover's bottom rim is gone entirely**, not merely notched. The rim projects
2 mm into the opening across Z 3–7, and a 35 mm converter in a 37 mm interior has
nothing to give. Three sides still locate the cover; the six screws hold it.

**Ports are connect-before-closing.** With the board turned, the ports open in the
plane of the board — up and down *inside* the box — so no wall needs a cutout and
the cover can be solid. Ethernet and HDMI use right-angle adapters, which is not
optional: a straight RJ45 plug needs ~40 mm below the board edge and the converter
top is at 18.

**The 21 mm budget.** Below the board edge (Z 39) down to the converter top
(Z 18) there is 21 mm, across the converter's full width. Treat it as the hard
limit on how far any adapter may project downward, and pick the variant whose
socket faces the **cover**, since that is the direction you are coming from when
the box is open. Note this moved the wrong way: it was 22 mm against the previous,
smaller converter.

One thing to weigh: at 72 mm wide the box spans X 63.1–135.1, which leaves room
for **one** antenna mount on columns 1–2 (X 18.6–53.6) with a 9.5 mm gap. At the
original 80 mm there was no room for one at all.

#### 11c — `compute_box_front_cover`

![cover](img/compute_box_front_cover.png)

A plain 3 mm panel with a locating rim nesting inside the opening. **No screws, no
vents** — it is held on with velcro tape.

The rim is a **4 mm rim, not a slab**. A solid plate here cost 22 cm³ and stole
2 mm of interior depth from a box with 1 mm to spare over the SBC.

**Velcro replaced six M3 screws, and that resolved a defect rather than dodging
one.** For several revisions this cover had six clearance holes with nothing behind
them: the box cut their insert pockets at X 9 and 63 while its side walls only
existed at X 0–3 and 69–72, so every cut landed in open air and removed nothing.
`cmf_cov_boss` was defined in the model and never referenced. No mesh check could
see it — subtracting from empty space is a no-op, not an error, and the part stayed
watertight and single-shell throughout. It was found on a printed part. Bosses were
then built and verified, and dropped again when velcro turned out to be lighter and
simpler; the box saved ~6 cm³ of plastic and six brass inserts with it.

**Two things follow from having no fixings.** The rim is now the only thing
aligning the cover, and it is **absent along the bottom edge** — notched full width
so the converter can sit flat — so the cover is located on three sides only.
Nothing but the tape resists it sliding downward. And the velcro lands on the box's
3 mm front edge: 464 mm of perimeter, about 14 cm² of area, but a narrow strip, so
tape wider than 3 mm will overhang inward and foul the rim.

The eighteen vent slots are gone too. They were sized when the box still breathed
through an M3 grid that no longer exists, and were judged of little practical value
in a bag-carried box. **If an SDR or anything else warm goes inside, revisit airflow
deliberately rather than by reinstating them.**

#### 11d/11e — `compute_box_front_slim` and its cover

![slim box](img/compute_box_front_slim.png)

A stripped alternative to `_front`, carrying **only the La Frite and its
converter** — no audio fob, no PTT board, no GPS. Nothing is shared with the deep
box except the rail bolt pattern and the board's own numbers, so the two can
diverge freely.

|                 | `_front` | `_front_slim` |
| --------------- | -------- | ------------- |
| Outer           | 72 × 160 × **40** | 72 × 160 × **32** |
| Volume          | 84.5 cm³ | **73.9 cm³** |
| Converter       | flat on the floor | **upright against the back wall** |
| Standoffs       | 8 mm | 8 mm |
| 12 V entry      | back wall, X 12 / Z 28 | back wall, X 56 / Z 46 |
| Switch          | left, X 20 | right, X 52 |
| Both top holes  | on the depth centreline, Y −20 | on the depth centreline, Y −16 |
| USB             | D-hole, X 54 | D-hole, X 20 |
| Also carries    | fob, PTT | — |

**Standing the converter on the back wall is what makes it flatter.** On the floor
it consumed 35 mm of depth and forced the box to 40; upright it consumes 15, and
the 35 becomes height — which this variant can spare, because the fob, PTT board
and GPS are gone. It is held flush by two M3 through the back wall, **countersunk
in the outer face**: the bottom-front crossbeam lies directly behind that wall over
box-local Z −4 to 20, so a proud screw head at Z 16.5 would stop the box seating on
the beam.

**The 12 V entry forced the board upward.** It has to be in the back wall, and at
the original board height there was nowhere for it: Z ≤ 20 has the crossbeam
behind it, Z 3–38 is covered by the flush converter, Z 38–42 was a 4 mm gap, and
above that is the board. Moving the board up 13 mm to Z 55–119 opens a 17 mm band;
Ø12 at Z 46 clears the beam by 20 mm, the converter by 2 and the board by 3.

**Switch and USB are on opposite sides from the deep box, deliberately.** Here the
12 V entry is at X 56, so the switch — which breaks the 12 V line — sits at X 52
beside it, and the 5 V output leaves from the other end. Same principle as the
deep box, mirrored because the power entry is mirrored.

Clearances are tight at the top: a 30 mm USB flange centred at X 20 and a 32 mm
switch bezel centred at X 52 leave **1 mm between them**. 62 mm of hardware across
a 72 mm wall, with 9 mm taken by the two outer edges. **Anything wider than 30 mm
will not fit beside the switch at any position.**

Its cover is the same plain velcro panel as 11c, sized to the 32 mm depth.

![slim cover](img/compute_box_front_slim_cover.png)

**The USB bulkhead is the same D-form as the deep box** — Ø12 with the top and
bottom flattened to 11 mm across, measured 12.00 × 11.05. It replaced an assumed
14 × 8 slot with two M3 at 24 mm centres, which was the wrong shape for this
connector and needed two fixings it does not use.

Losing those fixings bought back the clearance that was the tightest thing on this
part. The 24 mm screw span made the hardware 30 mm wide and left **1 mm** to the
switch bezel; a bare Ø12 leaves **10 mm**.

#### `compute_box_front_populated` — a layout aid, not a printable part

![populated](img/compute_box_front_populated.png)

The box seen straight through its opening with representative blocks where the
electronics go, for planning cable runs and judging free space before wiring.

| colour | component | source |
| --- | --- | --- |
| red | buck converter, 65 × 35 × 15 | **measured** |
| green | La Frite, 64 × 56 (dark = connectors and eMMC) | **measured**, with its M3 pattern |
| yellow / amber | right-angle Ethernet / HDMI adapters | placeholder |
| blue | CM108/CM119 audio fob | placeholder |
| orange | PTT board | placeholder |
| purple | GPS module | **no longer drawn — it does not fit** |

**Only the converter and the board are real measurements.** The other five are
typical parts, not the ones you will fit — correct them by editing `cmf_dev_fob`,
`_ptt`, `_gps`, `_rj45` and `_hdmi`.

Two things to know about using it:

- **Render in PREVIEW, not `--render`.** CGAL discards `color()`, so a full render
  comes out monochrome and useless for this purpose. The shell is drawn with `%`
  so it ghosts.
- The layout is only free in the **top bay**. Everything else is forced: the
  converter fills the floor, the M3 pattern fixes the board, and the two adapters
  have to live in the 21 mm between the board edge and the converter — which is
  why they are drawn crowding that gap.

The first version of this drawing put the top-bay devices flat on the back wall
and they fouled the M4 bolt pads — 2 mm deep over 22.5 mm of height, confirmed by
a clash check rather than by eye. They are now drawn 1 mm forward of the pads.
**That overlap is accepted rather than designed around**, since the box is bolted
up once and not routinely removed; the drawing simply shows where it happens.
Depth in that bay is 31 mm clear of the pads, 37 mm if a device straddles them.

---

### Radio mount positions — why two sets of holes

The two radios differ almost entirely in the dimension that becomes the standing
height in this frame:

| Radio            | W × D × H          | Standing height | Mount hole |
| ---------------- | ------------------ | --------------- | ---------- |
| Retevis RT-95    | 124 × **163** × 39 | 163 mm          | **Z 98**   |
| AnyTone AT-779UV | 124 × **101** × 36 | 101 mm          | **Z 129**  |

With a single hole at Z 98 and each radio's side hole at its own mid-depth, the
RT-95 spans Z 16.5–179.5 — filling the frame with its face flush at the top. The
AT-779UV spans Z 47.5–148.5, leaving its control face 31 mm down inside the
frame. That is the "too low" symptom exactly, and it makes the offset
(163 − 101) / 2 = **31 mm**. At Z 129 the AT-779UV's face reaches the same 179.5
the RT-95 does.

The two Ø26.468 recesses end up 4.5 mm apart. The material between them is full
9 mm thickness — only the recess discs themselves are thinned to 3.5 mm.

---

---

## 3. Deliberate deviations from the reference

These are engineering necessities, not preferences. Each is a parameter.

| Change               | From                                                                  | To                                                       | Why                                                                                                                                                                                                                               |
| -------------------- | --------------------------------------------------------------------- | -------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Crossbeam section    | 7 × 4 mm                                                              | **16 × 24 mm**                                           | An M4 heat-set insert needs a Ø5.7 × 9 mm pocket. It physically cannot fit in a 7 × 4 mm beam. This is the direct cost of the M4-bolted requirement.                                                                              |
| Frame depth          | 60 mm                                                                 | **70 mm**                                                | With four beams instead of two, front beams now exist at the top. At 60 mm deep they would overhang the radio's upward-facing control panel by 12 mm per side. At 70 mm the overhang is **zero** — verified in `img/asm_top.png`. |
| Panel thickness      | 8.25 mm                                                               | **9.0 mm**                                               | Leaves 5.0 mm under an M4 counterbore and 3.5 mm under the M5 recess (reference: 2.75 mm).                                                                                                                                        |
| Antenna gusset       | one 8.25 mm rib in the rail plane                                     | **two 5 mm ribs, one per bracket edge**                  | A bolt-on bracket has no rail plane to hide the rib in. Duplicating it onto both edges keeps the bore under the hole clear and makes the bracket symmetric; 5 mm rather than 8 mm leaves a clear central span for the bolts.      |
| Antenna hole spacing | 101.5 mm                                                              | **70–77.25 mm**                                          | Set by which top-front layout the brackets sit on (§2.11): 77.25 mm on `_dual`, 76 mm on `_triple`, 70 mm on `_grid`.                                                                                                            |
| Handle thickness     | 8.25 mm                                                               | **9 mm**                                                 | The handle is integral to the side panel, so it is simply the panel's own thickness. No axial insert is needed because it no longer bolts to anything.                                                                            |
| Handle form          | squared loop, 30 mm proud, 33.75 × 18.5 aperture under an 11.5 mm bar | **arch, 20 mm proud, 40 × 13 aperture under a 7 mm bar** | The built pack showed the squared loops reading as two blocky slabs — hard on the bag it only just fits, and hard on the hand. See §2.6.                                                                                          |
| Leg standoff         | 45 mm of integral leg                                                 | **25 mm base plate**                                     | That 45 mm of dead space is now where a bolt-on module goes. The plate went 16 → 25 mm to raise the bottom crossbeams, which is what makes the unified panel+handle printable (§2.6).                                             |

Unchanged on purpose: inner span 124.25 mm, M5 hole Ø5.000 at the bay centre,
Ø26.468 × 5.5 recess, Ø12.468 antenna hole, 3.75 mm pad, 25 mm reach, 12.66 mm
setback, 33.75 × 18.5 aperture, 11.5 mm grip bar.

**Dropped:** the reference's back stiffener fins and the rail tying the two
antenna ears. Both existed to stiffen a two-beam frame; the four-beam box makes
them redundant.

---

## 4. Hardware

All bolts stainless, socket cap. Structural inserts are brass M4, 6.0 mm OD ×
8.0 mm long (Ruthex/Bumat type) — pockets Ø5.7 × 9.0 mm with a Ø6.6 lead-in
chamfer. **M3 inserts appear only in the compute boxes**, at the SBC standoffs in
all three variants — pockets Ø4.0 × 5.0 mm, or 7.5 mm at the standoffs, which take
7 mm inserts. Everything structural stays M4.

| Joint                           | Bolt           | Qty                      | Insert lives in                      |
| ------------------------------- | -------------- | ------------------------ | ------------------------------------ |
| Side panels → **top** crossbeams | M4 × 12       | **8**                    | crossbeam ends                       |
| Side panels → **bottom** beams, through the battery box's tabs | **M4 × 20** | **8** | crossbeam ends |
| Antenna mounts → top-front beam | M4 × 12        | 8                        | top-front beam front face            |
| Inline box cover → bottom beams | M4 × 12        | 4 *(mid-rework, see §8)* | bottom beam undersides               |
| Inline box tray → its cover     | *none at present* | —                     | removed; see §8                      |
| Compute box (front) → beams     | M4 × 12        | 4 top + 2 bottom         | box back-wall pads / beam front face |
| SO-239 flange → antenna mount   | M3 × 10 + nut  | 4 per mount              | (through-holes; SO-239 variant only) |
| La Frite → compute box          | M3 × 8         | 4                        | box standoffs                        |
| Cover → compute box             | *velcro tape*  | —                        | (was 6 × M3; see §11c)               |

| **Radio → side panels**         | **M5 × 10–12** | **2**                    | the radio's own threaded side holes  |
|                                 | **M4 total**   | **24 bolts** — 16 × M4 × 12 + **8 × M4 × 20** | frame with battery box, no compute module |

M4 × 12 is correct **everywhere except the eight bottom-row bolts**: 4.0 mm
counterbore, plus 5.0 mm of remaining panel, plus 7.0 mm of thread engagement,
against a 9.0 mm pocket. Do not fit longer bolts there — M4 × 16 bottoms out.

The eight through the battery box's tabs are **M4 × 20**: 4.0 counterbore + 5.0
panel + **9.0 tab** + 6.0 engagement. One millimetre less engagement than the rest
of the frame, which is still 1.5 × D and well inside what an 8 mm brass insert
holds. **M4 × 25 bottoms out** — it would need 11 mm of a 9 mm pocket.

Check the M5 length against your radio's actual side-hole thread depth. With the
head seated 5.5 mm down in the recess, an M5 × 12 gives 3.5 mm through the panel
and 8.5 mm into the radio.

---

## 5. Printing

| Part               | Orientation                       | Notes                                                                                                                         |
| ------------------ | --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `side_panel`       | flat, **inner** face down         | M5 recess and all 8 beam counterbores open upward; only 4 × Ø8.2 bridges                                                      |
| `crossbeam` ×4     | long axis on the bed, 24 mm tall  | end **and** front-face inserts both come out in-plane                                                                         |
| `handle`           | flat, mating face down            | one bridge over the grip aperture; flattest face becomes the lap joint                                                        |

| `compute_box_front`| back wall down, open front up     | standoffs and all pockets open upward; the floor is flat and unbroken                                                         |
| `compute_box_front_populated` | — | **not printable.** Layout aid; render in preview so `color()` survives |
| `compute_box_front_cover` | flat, rim up               | panel face on the bed; plain panel, nothing to bridge                                                                         |
| `compute_box_front_slim`  | back wall down, open front up | same as the deep box; converter posts are gone, so the back wall is flat                                                   |
| `compute_box_front_slim_cover` | flat, rim up          | as 11c                                                                                                                        |
| `antenna_mount` ×2 | on its back                       | every layer smaller than the one below — no supports; one symmetric part, print two                                           |
| `base_plate`       | upside down, flat top face on bed | feet and every insert mouth point upward; fully self-supporting                                                               |
| `compute_box_inline` | feet down, open side up         | **the one part that needs supports** — the floor lands in mid-air over the four feet; see §12                                 |
| `compute_box_inline_cover` | flat, bolt heads up       | plain slab; the counterbores and insert mouths all open upward                                                                |
| `battery_box`      | **back wall down**, open front up | floor-down would cantilever both top flanges 19.5 mm along their whole length; on its back they become ribs off the back wall. **Two of the four tabs now need support** — see §8 |

Each `part=` value in the .scad already emits the part in its recommended pose,
so `stl/*.stl` are ready to slice as-is. **Do not re-orient them** — the poses
are not arbitrary, and two of them were chosen to fix specific defects (§9).

Material choice and full slicer settings are in **§9**.

**Insert-direction note:** the beam end inserts, the beam front-face inserts and
the handle inserts are all in-plane in their recommended orientations, so bolt
tension pulls against knurls rather than trying to delaminate layers. The two
exceptions are the base-plate feet inserts and the bottom-beam underside
inserts, both of which are loaded in compression by the pack's own weight.

---

## 6. Assembly order

Order matters in one place: the two front compute boxes must be bolted on before
their switch and USB bulkhead go in (step 10). Nothing else is order-sensitive —
the handles are integral to the side panels now, so the old "top beams first"
constraint from the lap pads is gone.

![exploded](img/exploded.png)

1. Heat the inserts. **16 in the beam ends** (two per end, four per beam) — do
   these first and check each pair is square, or the panel will not sit flat — plus
   the top-front beam's accessory columns, which vary by layout: 14 on `_grid`.
   The four in the bottom beams' undersides are only needed if you fit
   `compute_box_inline`. **The battery box takes no inserts at all now** — its tabs
   are plain through-holes; the threads are all in the beam ends.
2. Bolt the two **top** crossbeams to one side panel (8 × M4 × 12, heads on the
   **outside**).
3. **The bottom beams and the battery box go on together.** Stand the box's four
   tabs against the panel's bottom rows, offer both bottom beams up to them, and
   run the eight **M4 × 20** through panel → tab → beam. There is no base plate,
   and the beams will not reach the panels without the box. Then add the second
   side panel and repeat.
4. Drop the radio in and fit the two M5 bolts through the panel recesses into
   the radio's side holes.
5. *(No handle step — the handles are part of the side panels, fitted in step 2.)*
   Note the panel now carries **two bolt rows per beam**, eight per panel.
6. Bolt on the two antenna mounts (8 × M4 × 12), then fit the antenna
   connectors.
7. *(No separate battery-box step — it went on in step 3.)* Route the pack's lead
   up past the flange into the bay, slide the pack in from the front and strap it.
8. If fitting `compute_box_front`, populate it **before** the cover goes on —
   the downward-facing power and Ethernet connections are not reachable once it
   is closed. Order inside the box: converter onto the floor first (two M3 through
   the floor into its slotted tabs, 12 V in through the back-wall grommet), then
   the La Frite on its four M3 standoffs — **start all four screws before
   tightening any of them** — then the right-angle adapters, then USB devices in
   the top bay. Cover last — velcro, no tools.
9. *(No microphone bracket at present — see §2.6.1.)*

10. **Bolt either front compute box to the crossbeam BEFORE fitting its switch and
    USB bulkhead.** Both cover the M4 heads once installed — the switch bezel and
    the bulkhead sit directly over them, and although neither *touches* the bolt
    pads, neither leaves a driver anywhere to go. This is deliberate: the top wall
    is 72 mm and the switch bezel alone is 32, so no arrangement frees both bolt
    columns. The box is a fit-once item; the cover comes off far more often, and
    velcro means that needs no tools at all.

---

## 7. Verification performed

Not just rendered — checked:

- All 15 meshes watertight, **single connected shell**, within 180 × 180.
  (This caught two real defects: the antenna gusset and the base-plate locating
  lips initially only touched their neighbours on a coplanar face, producing
  two- and three-shell parts.)
- **Zero interference** across all 66 pairs of parts in assembled position,
  including the radio envelope.
- **All 36 M4 bolt axes and both M5 axes** traced: each passes through a
  clearance hole in one part and lands inside the insert pocket of the other,
  with no material fouling the shank.
- Antenna bore clear below each pad for the connector body, and for the SO-239
  variant all four flange-screw nut positions clear.
- **Void connectivity**: every M4 counterbore traced back to outside air, and
  both antenna brackets confirmed to contain **zero enclosed voids**. This is the
  check that would have caught the v1 bracket, whose two right-hand bolt holes
  were sealed inside the rib.
- Both antenna variants confirmed **mirror-symmetric in X**, so one part serves
  both sides.
- All 16 accessory-rail bolt axes traced into the crossbeam's inserts, and the
  station-to-station clash table computed from real part widths rather than
  assumed.
- Battery box: all four bolts traced into the base plate's foot inserts, cable
  column clear through both parts, zero enclosed voids.
- **Recursive stack test**: a second battery frame placed one pitch (59.8 mm)
  below the first shows zero interference and all four bolts running cleanly from
  the lower flange into the upper frame's foot inserts. The module interface
  therefore repeats indefinitely.
- Battery frame's rearmost point is Y 69.99 against a frame back of 70.0 —
  nothing protrudes behind the wearer.
- Handle after the arch rework: self-supporting in its print pose (the only
  growing layers are the four insert pockets' chamfers and ceilings), mating face
  flat at 2055 mm², all four bolt axes still landing in their inserts with the
  narrower 15 mm legs, and the assembly's tallest point down to 199.95 mm.
- Arch band thickness scanned along the whole span, not just at the apex. This is
  what caught the waist at the arch/shoulder joint; the band is now measured at
  7.0 mm minimum, rising to 8.25 mm at the shoulders.
- Full load-path check at one-handed lift with a 3× snatch (54.7 N on one handle,
  from a measured 1.86 kg pack): arch apex 5.5 MPa, legs 0.15, bolt bearing 0.28,
  insert shear 13.6 N each, lap peel 13.6 N/bolt, lateral across layers 3.3 MPa.
  The handle prints flat so arch bending runs along the filaments, not across
  layer bonds.
- Battery box print pose swept for unsupported area: **+385.4 mm² appears at bed
  Z 54** — the two front-beam tabs starting in mid-air. The back-beam pair sit on
  the bed and are fine. Everything else in the sweep is `rbox` corner rounding.
- Tab joint, traced in **frame** coordinates by mapping the battery box's print
  pose back: tabs at **X 9.02–17.98 and 124.28–133.22** against a nominal 9.00–18.00
  and 124.25–133.25, **Z 25–49** flush with the beam tops, over the beams' Y bands
  of 0–16 and 54–70. The radio band at Y 17–53 confirmed clear between them, which
  is why there are four tabs and not two full-depth ones.
- All eight tab bolt holes break the tab exactly on the beam rows: air gaps
  measured at **Z 29.30–33.68 and 40.30–44.68** against a nominal Ø4.4 at 31.5 and
  42.5. Bottom beams measure 106.22 long against 106.25 nominal, end pockets ~9 mm.
- Battery box watertight, single shell, 111.27 cm³, flat-bottomed at Z −26.8 with
  nothing below it. Two faults caught getting there: the tabs sitting exactly on
  the flange plane produced **five separate shells** (coplanar contact, not a
  union) and are now sunk 1 mm; and the print pose still offset by the deleted
  feet, leaving the part floating 25 mm off the bed.
- Whole-library rebuild diffed against the previous commit: **exactly four parts
  changed** — the three bottom beams and the battery box. Side panels, top beams,
  antenna mounts and all three compute boxes are geometrically identical, which is
  the check that confirms `z_frame` still holds as a datum and no panel needs
  reprinting.
- Compute boxes: SBC envelope (64 × 56 board + 22 mm of connectors) traced clear
  of the walls and top flanges, all three variants single-shell with zero enclosed
  voids.
- `compute_box_inline`: tray 142.98 × 99.98 × 46.99 / 116.71 cm³, cover
  142.98 × 99.98 × 7.98 / 104.73 cm³, both watertight and single-shell; stacked
  height **55.00 mm** against the 55 mm budget. Cavity sectioned at 35.00 mm.
  Converter and board footprints traced against the interior: 0.5 mm clearance to
  the back wall, 36.5 mm of connector zone at each end of the board, 10.4 mm of
  headroom over it.
- Raceway, traced by largest-contiguous-air run: **Y 33.26–49.00 = 15.76 mm**,
  identical at the tray's floor, at mid-cavity, at the inboard mouth, and through
  the cover — four stations agreeing to the 0.02 mm probe step. In X the tray runs
  117.50 out through the side face; the cover stops at 132.24, i.e. **10.00 mm in
  from the frame edge**. Walls solid front, back and inboard, each sampled at two
  X stations.
- **Floor opening against the battery feet: 0 of 3723 grid samples fall over
  either**, nearest boss edge 1.00 mm away. This check governs the channel's Y, and
  it is what condemned the second raceway version — that one put 160 mm² of the
  opening straight onto the boss the battery bolts into, measured at the time and
  wrongly accepted.
- Cover confirmed solid under the side panel at (137, 41) and under both bottom
  crossbeams at (125, 8) and (125, 62) — the side-wall route costs no bearing
  anywhere, unlike every back-edge version. Board's right connector zone confirmed
  still open. All four feet intact (24/24 on an r = 6 ring); all four cover M4s
  present.
- This family of checks caught four earlier raceway versions: one that cut through
  into the cavity, one whose kept block was exactly as wide as the notch and so had
  no side walls, one that sat on the battery foot, and one squeezed to 6.90 mm
  between the foot and the beam bolt.
- Six former tray screw-pad sites re-probed after removal: all six read air.
- `compute_box_front` after the rework: all four standoffs located by **counting
  solid islands standing proud of the back wall**, not by point-probing — four at
  X 11.25 / 60.75 × Z 41.65 / 100.35, each 38.0 mm², which is a Ø8 pad minus its
  Ø4 insert pocket to the decimal. This was the check that finally settled the
  board rotation; three earlier point-probes of the same feature were wrong (see
  below). Spacing re-measured after the correction: 58.70 on a 0.5 mm grid against
  the 58.75 modelled, and 49.50 across.
- Standoff height and pocket depth traced through the thickness: pad solid to
  bedZ 8.95 (6 mm proud of a 3 mm wall) with the pocket open from 2.95, i.e. the
  full 6 mm.
- Converter fixings swept across the floor: two Ø3.40 holes at X 9.03 / 63.03 —
  **54.00 mm apart**, symmetric about the box centre at 36.03 — and 13.50 mm back
  from the inside face, through the full floor thickness.
- Back-wall power entry after moving it left: open X 6.05–18.00, Ø12.00, centred
  12.03 and wholly inside the first quarter; the old centred position at X 36
  re-probed solid, confirming it moved rather than gained a second hole.
- Back wall re-swept after removing the grid and the cutout: 2146 points, exactly
  four voids remaining, all four on the M4 clearance holes.
- Buck converter (65 × 35 × 15, measured) traced clear sitting flat on the floor,
  and the clear interior measured by contiguous-run sweep at five heights:
  **66.05 mm wide, constant the full height of the bay** — no fillet loss — and
  37.05 deep.
- Back-wall power entry traced against the bottom-front crossbeam: open across
  box-local Z 22–34, solid again at Z 19 and Z 37, so it opens into the gap
  between the beams rather than into beam material.
- Cover rim: bottom band verified gone across the full width, the other three
  bands intact, and the panel **not** holed beneath it. After the switch to velcro,
  the panel re-checked for zero through-holes.
- Deep box top wall swept across X at eight depth bands: openings appear **only**
  at Y −16 to −24, and only two of them — the switch bore and the USB D-form. Every
  other band solid, which is how the removed rim slot was confirmed gone rather
  than merely moved.
- SMA hole traced through the right wall: Ø6.55 at Y −20 / Z 118, wall solid again
  at Z 108 and Z 128, left wall untouched at the same coordinates.
- Slim box: seven islands proud of the back wall counted at bedZ 7 — four standoffs
  at 49.5 × 58.75, two converter posts 54 apart, and the M4 pad slab (posts have
  since been replaced by countersunk through-holes).
- Unified side panel: beam inserts and panel holes measured **independently** and
  compared — 31.48 / 42.48 from the beam mesh, the same from the panel mesh. This
  is the check that caught an earlier attempt where the panel had been trimmed and
  the beam rows moved, leaving the beams protruding 6 mm below the panel.
- Panel rounding verified by scanning the grip bar's underside at nine depths
  through the 9 mm plate (193.98 at each face, 193.04 across the flat), the outer
  edge either side of the Z 180 junction (0.06 mm difference), and the inner face
  at every beam seat (Y 0.04 / 69.96, flat).
- `handle_mic`: M3 insert axes measured at Z 105.00 / 150.00 — 45.00 apart —
  scanned strictly inside each beam, and both apertures confirmed by a centreline
  sweep that finds exactly two runs (37 mm grip, 33 mm window). The plain `handle`
  re-exported and diffed against it: 0.0000 mm bounds, 0.0000 cm³.
- Base plate after opening the centre: perimeter coverage re-sampled under both
  side panels (100 %) and both crossbeams, material around all four feet and all
  four base bolts intact, the foot-to-opening ligament asserted at ≥ 1.5 mm, and
  the opening-to-panel margin fine-probed at 1.995 mm on both sides.
- **Regression check that nothing already printed was invalidated**: every STL
  compared against the committed version. Only `side_panel` and `base_plate`
  changed; the four crossbeams, both handles and both antenna mounts are
  bit-for-bit the same geometry.
- **Per-layer cross-sectional area of every shipped STL in its print pose**, to
  find material laid over voids. This caught two real orientation defects: the
  base plate printing 98 % in mid-air on two locating lips, and the side panel
  bridging a Ø26.5 mm ceiling directly under the ligament that carries the
  radio. Both are fixed. `compute_box_inline` has since reintroduced the same
  class of defect and is the one part that still needs supports (§12).
- Asserts in the model fail the render if the panel exceeds the bed, the beam
  span exceeds the bed, `frame_d` is too small to clear the control panel,
  `bay_h` is too small for the radio, or the M5 recess leaves < 3 mm of panel.

**A subtraction that removes nothing is invisible to every check here.** The
cover's six screw bosses were never built, and the model still exported watertight,
single-shell, void-free, with correct bounds and volume — because cutting a
cylinder out of empty space is a no-op, not an error. No mesh property distinguishes
"this feature was made correctly" from "this feature was never made". The check that
would have caught it is the one already used for bolt axes elsewhere: **trace every
fastener from its clearance hole into the material that is supposed to receive it,
and assert that material exists.** That check was applied to the M4 frame joints and
not to the M3 cover screws.

**A bulk re-export makes every part look modified.** OpenSCAD writes byte-different
STLs for identical geometry, so re-exporting everything to check nothing broke left
19 files showing as changed when only 3 had actually moved. Always diff bounds and
volume against `HEAD` and restore the rest, or the reprint list reads far worse than
it is and the real changes are buried.

**Point-probes lie more often than the geometry does.** Every false alarm during
the compute-box and handle work was a bad measurement, not a bad part, and they
failed in ways that looked exactly like real defects:

| what was probed | why it read wrong |
| --- | --- |
| SBC pad centres | the centre *is* the M3 insert pocket — empty by design |
| pad walls, as a ring with `.all()` | the ring straddled a slot, so one open point failed the whole test |
| a point "inside the bar" | box-local coordinates against an STL exported in its print pose |
| M3 insert spacing | the scan window ran past the beam into the finger opening and averaged two voids |
| clear interior width | took `min`/`max` of all free points instead of the largest contiguous run, so one ambiguous point exactly on the boundary stretched the span by 3 mm and implied a missing wall |
| cover rim, top band | probed at Y 157, past the rim's own end at 156.6 |

The habits that catch these: probe a **control** you know the answer to in the
same run, prefer **cross-sections and island counts** over point sampling for
anything whose size matters, and confirm the coordinate mapping against a known
feature before trusting a sweep.

Reported clearances at the shipped parameters:

```
frame body            = 142.25 x 70 x 180 mm
assembled envelope    = 142.25 x 108 x 200 mm  (depth shown for the deeper SO-239 bracket)
radio bay (WxDxH)     = 124.25 x 38 x 107 mm
radio clearance  side = 1 mm/side   above/below = 3 mm
panel print footprint = 175 x 70  (bed 180) -> margin 5 mm
panel under M5 recess = 3.5 mm of material carrying the radio
```

---

## 7.1 What to reprint after the unified-panel change

Geometry diffed against the previous commit — bounds and volume, not bytes, since
OpenSCAD re-exports differ byte-wise for identical geometry.

| Part | Why |
| --- | --- |
| `crossbeam_bottom_front` | 124.25 → **106.25 mm**; the tab joint (§2.9) |
| `crossbeam_bottom_back` | 124.25 → **106.25 mm**; the tab joint |
| `crossbeam_bottom_front_rail` | 124.25 → **106.25 mm**; the tab joint |
| `battery_box` | gains four tabs, loses its feet, top face moves to the frame datum |
| `side_panel` ×2 | the unified panel + handle |
| `base_plate` | 16 → 25 mm thick; this is what raises the bottom crossbeams so the panel fits the bed |
| `compute_box_inline` | superseded entirely — the old part was a 142 × 70 × 49 open frame bolting *up* into the plate. The new one is a 143 × 100 × 55 closed box that **replaces** the plate. |

**Nothing else changed.** All four crossbeams, both antenna mounts, the battery
box, both front compute boxes and their covers are byte-for-byte identical.

The base plate is not optional alongside the panel: a 175 mm panel bolted to a
frame still using the 16 mm plate would leave the beams 9 mm below where its holes
are.

---

## 8. Open items — read before printing

1. **Verify the M5 hole position against the radio in hand.** The reference puts
   it at the exact centre of the bay in both Y and Z, and that is the only
   evidence available for where the radio's threaded side holes actually sit.
   `radio_by` and `radio_bz` are one-line changes; everything else follows.

2. **`radio_h = 36` and `radio_d = 101` are assumptions**, and they are the two
   numbers that matter: `radio_h` sets `frame_d` (70 mm gives zero control-panel
   overhang) and `radio_d` sets `bay_h`. Re-measure before committing 400 cm³ of
   filament. The echo block above reports the resulting clearances on every
   render.

3. **The radio hangs on two M5 bolts through 3.5 mm of plastic, with nothing
   resisting rotation about that axis.** This is inherited from the reference,
   which is thinner still at 2.75 mm. It is the frame's single biggest structural
   risk. If it worries you, the fix is a bottom ledge or a back-biased top boss
   on the side panels — but that adds features to a part the brief specifies as
   carrying the radio mount only, so it has been left alone rather than added
   unasked.

4. Side clearance is **1 mm per side** in Y between the radio and the top
   crossbeams. That is deliberate — it is what buys zero overhang over the
   control panel — but it means a radio thicker than 38 mm needs `frame_d`
   increased.

5. **The RT-95 does not fit this frame in Y.** Its 39 mm body against the 38 mm
   clear channel between the front and back crossbeams is a **1 mm
   interference** — the mount holes at Z 98 are right for it, but the beams are
   1 mm too close. The fix is `beam_d` 16 → 15, giving 40 mm clear, but that
   means reprinting all four crossbeams, so it has been left alone rather than
   forced on a frame that is already built and working with the AT-779UV. The
   model prints a warning rather than failing when `radio = "rt95"`.

6. The Ø26.468 × 5.5 mm recess is reproduced because the brief says to transfer
   the radio mounts, but its purpose is inferred: it is far too large for an M5
   head, so it is almost certainly a seat for the OEM knurled mounting knob. If
   you are using plain M5 socket caps, it can shrink to Ø10 and reclaim 2 mm of
   panel thickness under the bolt.

7. **`handle_mic`: confirm the bracket's holes are centred on its 55 mm height**
   before printing 101 mm of handle. That assumption puts 5 mm of bracket above
   the top hole and 5 below the bottom; if they sit off-centre, `mic_bolt_z`
   moves and the two beams move with it.

8. **`compute_box_front`: the converter fits with 0.5 mm a side on width.**
   65 × 35 × 15 measured, into a 66.05 mm interior. That is the tightest fit in
   the project and it is a print-tolerance call, not a clash — see §2.12. Also
   resolved: it is an LY-KREE XS120503 and its leads exit one end. The Ø12
   back-wall entry now sits at **X 12**, in the first quarter, chosen to keep the
   12 V run away from the Ethernet and HDMI adapters on the board's downward edge.
   Note this puts power and the Ethernet lead in the same corner; if the intent is
   to separate power from *both* port leads, the right-hand quarter would do it
   better, and `cmf_grom_x` is a one-line change.

9. **Right-angle Ethernet and HDMI adapters are required, not optional**, and
   neither has been dimensioned. A straight RJ45 plug needs ~40 mm below the
   board edge; the converter is at 22 mm. The hard limit on any adapter's
   downward projection is **21 mm**, across the converter's full width. Measure
   from the plug's mating face to the back of the housing. If it exceeds 21 mm the
   only real lever left is moving the converter out of the bottom bay — the rim
   notch and the floor drop have both already been spent.

10. **RESOLVED — the cover is now velcro-closed** (§11c). It previously had six
    screws with no bosses to land in. Both the screws and the vent slots are gone.

11. **The M3 insert pocket diameter is still 4.0 mm and is probably wrong.**
    `m3_ins_d` was sized for a shorter insert; the SBC standoffs now take a 7 mm
    insert, and those typically run 4.6–5.0 mm OD. Depth has been corrected to
    7.5 mm but the diameter has deliberately **not** been guessed — too small
    splits the boss, too large and the insert spins. Measure the OD before
    printing. This affects the four SBC standoffs in both front boxes; the cover
    and mic-bracket inserts are a different, shorter part and keep 4.0.

12. **The switch body depth (30 mm, measured with cables) leaves 24 mm under it.**
    That is now the binding constraint on the top bay, not the bay's 54 mm height.
    Check any PTT board against ~23 mm before assuming it fits.

13. **La Frite port positions along the board edge are not modelled.** The box is
    sized to the board outline and its M3 pattern; which port sits where along the
    now-downward edge is unverified, so the 21 mm budget is assumed to apply to
    all of them equally.

---

14. **`compute_box_inline`: the buck converter's own 12 V feed has no modelled
    path.** The raceway is deliberately sealed off from the cavity, so the battery
    leads running up it never enter the box — but the converter *inside*
    the box has to be fed from those same leads. Nothing in the model gets them
    across the raceway's 3 mm wall. That wall is now the channel's **inboard** face
    at X 114.5–117.5, and the converter ends at X 96.5, so the run is no longer
    trivially short — 18 mm of cavity separates them. Either drill the left wall
    and bridge that gap inside the box, or bring 12 V in through the cover's cable
    opening with the rest of the wiring. **Decide which before you
    close the box** — the converter's terminals are the least accessible thing in it.

15. **`compute_box_inline` is mid-rework and cannot currently be fitted.** The tab
    joint shortened the bottom beams, so the inline box — which bolts up into their
    undersides — no longer braces anything: with it fitted and no battery box, the
    beams stop 9 mm short of each panel. Its four beam-underside inserts are
    deliberately kept so it still bolts up as it did, but **it needs tabs of its
    own**, which is the next piece of this rework. `compute_box_front` and
    `_front_slim` are unaffected.

16. **The battery box's two front tabs print on support. This is decided, not
    open** — recorded here so it is not re-litigated. The back-wall-down pose maps
    bed Z to 70 − frame Y, so the build runs back to front: the back-beam tabs land
    on the bed, but the front-beam pair start **54 mm up with 385.4 mm² in
    mid-air**. It cannot be designed out:

    - a self-supporting ramp would need 24 mm of run for 24 mm of rise and has only
      16 (the beam's depth) — and must be at full height by frame Y ≈ 10 to carry
      the bolt at Y 8, leaving 6 mm of run: **76° from vertical**;
    - a gusset would have to come from higher frame Y, which at Z 25–49 is the
      radio bay, and in X the tabs sit inside the radio's own 9–133.25;
    - floor-down fixes the tabs but cantilevers both top flanges 19.5 mm along
      their full 94.8 mm — about **3700 mm² against 385**.

    Support is the cheap breach: front and back tabs share an identical bed
    footprint, so the column stands on the **back tab, 38 mm tall, not 54 from the
    bed**, and the scarred face points into the radio bay. The tab's **mating faces
    are its two X faces**, against panel and beam, and those print as vertical
    walls. See the per-object modifier table in §9.

    The rejected alternative, if this ever proves annoying: make the four tabs
    separate 9 × 16 × 24 blocks (~3 cm³ total) that drop into sockets in the flange
    and are captured by the same M4 × 20. Zero supports, four more parts, and a new
    socket joint carrying the battery in a snatch load.

17. **`crossbeam_bottom_front_rail` takes an argument that does nothing.** The
    export passes `front_rows = [16]`, which is not a parameter of `crossbeam()`
    and is silently ignored — so the beam gets accessory columns on *both* rail
    rows, at beam-local Z 6 and 16, not the single row at 16 the comment describes.
    The row at 6 clears the underside inserts by **0.175 mm** of material (axes
    5.875 mm apart, two Ø5.7 pockets), so it is not a clash, but the comment and
    the code disagree and one of them is wrong. Not touched here — it would change
    a printed beam.

18. **`compute_box_inline` has no tray-to-cover fixing.** The six M3 pads were
    removed because they predated the cover inheriting the base plate's bolt
    pattern and did not relate to it. Until they are replaced the tray only sits
    under the cover. Next change to make on this part.

19. **`compute_box_inline` needs supports and should not.** ~13 000 mm² of floor
    prints in mid-air over the four feet (§12). It slices and prints with support
    under the first 8 mm, but the fix — feet as internal bosses, flat underside —
    also takes 8 mm off the stack. Decide before printing it; the change is not
    made yet.

20. **The 15 mm component height over the La Frite is assumed, not measured.** It
    is what gives the inline box its 10.4 mm of headroom in a 35 mm cavity, and the
    tallest thing on the board — a right-angle adapter standing off the connector
    edge, or a USB stick — is exactly what has not been put on a caliper. If it runs
    to 25 mm the box still closes; past that, the cavity has to grow and the 55 mm
    budget goes with it.

## 9. Print settings

### Overview

Slice `stl/*.stl` as-is. Every part is already in its recommended pose (§5) and
**two parts on this frame now need supports** — `compute_box_inline` (§12) and
`battery_box`, whose front pair of tabs start in mid-air (§8). Otherwise the
only ceilings anywhere are the
tops of insert pockets and bolt bores, the largest of which is the Ø12.468 mm
antenna bore through a 3.75 mm wall. Verified by measuring per-layer
cross-sectional area on all seventeen meshes; the biggest single unsupported area on
any layer is about 93 mm². The one exception is `compute_box_front_cover`, whose
counterbores and vents all open upward, and `compute_box_front`, whose floor is now
flat — the buck-converter ribs that once stood on it were removed when the rim
notch let the converter sit directly on the floor.

Two of those poses are load-bearing decisions rather than convenience, so do not
re-orient them in the slicer:

- **`side_panel` prints inner face down.** Flipping it puts a Ø26.5 mm bridged
  ceiling directly beneath the 3.5 mm ligament that carries the radio's entire
  weight through two M5 bolts. Inner-face-down makes that ligament ordinary solid
  layers and reduces the part to four trivial Ø8.2 mm bridges.
- **`base_plate` prints upside down**, flat top face on the bed. This is also why
  it has no raised locating lips: with the plate inverted — the only pose in which
  the feet and every insert mouth and counterbore point upward — the lips became
  the first layers and left 98 % of the plate printing in mid-air.

Five things matter more on this design than the usual quality knobs:

1. **Perimeters carry the load, not infill.** Every joint on the frame is either
   a bolt through a counterbore or a heat-set insert in a boss, and both react
   into wall material. Given a choice between more infill and more perimeters,
   always take the perimeters.
2. **Solid layers at the M5 recess.** The ligament under the recess is only
   3.5 mm — about 17 layers at 0.20 mm. With a slicer default of 4 top / 4 bottom
   solid layers, the middle of the one feature carrying the radio would be
   _infill_. Bump the side panels to **5 top / 5 bottom**, and — this is the part
   that actually guarantees it — apply the height range modifier described under
   _Per-object modifiers_ below, which forces that 4 mm band to 100 % solid
   regardless of layer height.
3. **The M4 counterbore is 4.0 mm deep for a 4.0 mm head — zero margin.** If your
   first layer is over-squished or elephant-foot compensation is set aggressively,
   heads will sit proud. This specifically matters at the four top-crossbeam
   bolts, because the handle lap pads seat directly on top of them: one proud head
   there and the handle rocks. Check with a straightedge before fitting handles.
4. **Ø8.2 mm counterbores will not accept an M4 washer** (≈Ø9 mm OD). Run the M4
   bolts bare. The M5 recess has room for a washer if you want one.
5. **Print one crossbeam first as a coupon.** `crossbeam_top_front_dual` carries 12 of
   the design's 40 inserts — four in its ends and eight in its front face — which
   is two of the three insert axes in one part. Test-seat one insert and run an
   M4 × 12 into it before committing the other three beams. (The third axis, the
   downward pockets in the bottom beams' undersides, is the only one loaded purely
   in compression, so it is the least critical to trial.)

Rough filament expectation for a complete 11-piece set — the slicer is the
authority, this is only for planning: **~250–300 g in PLA** at prototype
settings, **~400–500 g in PETG** at production settings.

Batch the four crossbeams together; they share an orientation and a profile.

### 9.1 Prototype / dev — PLA

Cheap and fast, for checking fit, clearances, radio hole alignment and handle
feel. **Not a field frame** — see the caveats at the end of this subsection.

| Setting            | Value                                              |
| ------------------ | -------------------------------------------------- |
| Nozzle / layer     | 0.4 mm / **0.20 mm**                               |
| Perimeters         | 2                                                  |
| Top / bottom solid | **5 / 5**                                          |
| Infill             | 15 % gyroid                                        |
| Nozzle temp        | 210 °C (first layer 215 °C)                        |
| Bed temp           | 60 °C                                              |
| Cooling            | 100 %                                              |
| Brim               | 5 mm on the four crossbeams; none needed elsewhere |
| Supports           | none                                               |

Why a brim only on the crossbeams: their footprint is 124 × 16 mm and they stand
24 mm tall, so they are the one narrow, tippy part in the set. Everything else
has a large flat first layer (`side_panel` 9714 mm², `base_plate` 9579 mm²).

**Why 0.20 mm and not something coarser.** The prototype's whole job is to check
the M5 hole position, the counterbore depths and the insert-pocket fit, and all
three shift with layer height — a coarser prototype would fail to validate the
very dimensions it exists to validate. The savings come from 2 perimeters and
15 % infill instead, which is where the bulk of the time and filament is anyway.
Keeping prototype and production on the same 0.20 mm layer also means what you
measure on the prototype still holds for the production run.

**PLA-specific caveats:**

- **Heat-set inserts:** iron at 200–210 °C and go slowly. PLA's window between
  "flows" and "gushes" is narrow, and an overheated boss will swallow the insert
  crooked. For a fit check, install only the inserts you actually need.
- **Torque finger-tight only.** PLA creeps under sustained preload; a PLA frame
  will loosen at every joint over days, and the two M5 bolts through a 3.5 mm
  PLA ligament are the worst case.
- **Do not leave it in a car.** PLA's glass transition is around 60 °C. A closed
  vehicle in sun will exceed that and the frame will sag under the radio's weight.
- **Cheapest useful subset:** caliper the radio first (free, and it settles
  `radio_h` / `radio_d` — see §8 item 2). Then print one crossbeam as the insert
  coupon. Then the two side panels plus four crossbeams, which is the minimum
  assembly that trial-fits the radio and proves both M5 holes. Leave the handles,
  antenna mounts and base plate until the bay geometry is confirmed.

#### PrusaSlicer 2.9.6 — PLA prototype profile (Prusa Mini, 0.4 mm nozzle)

Start from **`0.20mm SPEED @MINI`** — of the system presets the Mini offers
(0.10 FAST DETAIL, 0.15 SPEED, 0.15 STRUCTURAL, 0.20 SPEED, 0.20 STRUCTURAL) this
is the fastest at the 0.20 mm layer the prototype needs. Switch to **Expert**
mode, change the values below, then _Save Print Settings as_
**`MANPACK PLA 0.20 @MINI`**.

Setting names are as they appear on each PrusaSlicer Print Settings page.
Anything not listed keeps the base profile's value.

| Page                  | Setting                    | Value                                   |
| --------------------- | -------------------------- | --------------------------------------- |
| Layers and perimeters | Layer height               | **0.20**                                |
| Layers and perimeters | First layer height         | **0.20**                                |
| Layers and perimeters | Perimeters                 | **2**                                   |
| Layers and perimeters | Top solid layers           | **5**                                   |
| Layers and perimeters | Bottom solid layers        | **5**                                   |
| Layers and perimeters | Perimeter generator        | Arachne                                 |
| Layers and perimeters | Detect bridging perimeters | ✔                                       |
| Layers and perimeters | Seam position              | Aligned                                 |
| Infill                | Fill density               | **15 %**                                |
| Infill                | Fill pattern               | Gyroid                                  |
| Infill                | Top / Bottom fill pattern  | Monotonic                               |
| Infill                | Combine infill every       | 1                                       |
| Skirt and brim        | Brim type                  | Outer brim only                         |
| Skirt and brim        | Brim width                 | **5 mm** (crossbeam plate only, else 0) |
| Skirt and brim        | Brim separation gap        | 0.1 mm                                  |
| Support material      | Generate support material  | ✘ unchecked — **except `battery_box` and `compute_box_inline`**, see the modifier table |
| Speed                 | External perimeters        | **25 mm/s**                             |
| Speed                 | Bridges                    | **25 mm/s**                             |
| Advanced              | XY size compensation       | **0**                                   |
| Advanced              | Elephant foot compensation | 0.2 mm                                  |

**Filament Settings — a separate profile from Print Settings.** Temperatures and
fan live here, not in the Print Settings profile. Start from `Generic PLA`, save
as **`MANPACK PLA @MINI`**:

| Page     | Setting                          | Value           |
| -------- | -------------------------------- | --------------- |
| Filament | Nozzle temperature, other layers | **210 °C**      |
| Filament | Nozzle temperature, first layer  | **215 °C**      |
| Filament | Bed temperature, both            | **60 °C**       |
| Cooling  | Keep fan always on               | ✔               |
| Cooling  | Min / Max fan speed              | **100 / 100 %** |
| Cooling  | Bridges fan speed                | 100 %           |
| Cooling  | Disable fan for the first        | 1 layer         |

**One profile covers all four plates.** 5 / 5 solid layers is applied globally
rather than only on the side-panel plate, so there is nothing to remember when you
switch plates — the extra solid layer costs almost nothing on the beams and
brackets. The only per-plate change in the whole set is _Brim width_.

### 9.2 Production / final — PETG

| Setting            | Value                                                          |
| ------------------ | -------------------------------------------------------------- |
| Nozzle / layer     | 0.4 mm / **0.20 mm** (first layer 0.20 mm)                     |
| Perimeters         | **4** — 5 on the four crossbeams                               |
| Top / bottom solid | 5 / 5 — **6 / 6 on `side_panel`**                              |
| Infill             | 40 % gyroid                                                    |
| Nozzle temp        | 240 °C (first layer 240 °C)                                    |
| Bed temp           | 85 °C first layer, 90 °C after                                 |
| Cooling            | **30–50 %**, and do not let bridge/overhang fan spike to 100 % |
| Perimeter speed    | 40–50 mm/s                                                     |
| Brim               | 5 mm on the four crossbeams                                    |
| Supports           | none                                                           |

**PETG-specific notes:**

- **Keep the fan down.** This frame's strength lives in layer adhesion — insert
  bosses resist pull-out across layers, and the beam-end joints are loaded in
  shear across layers. Over-cooled PETG loses exactly that. Cool enough to hold
  detail, no more, and slow the perimeters rather than adding fan.
- **Dry the filament.** PETG is hygroscopic and wet PETG loses layer strength.
  This is the single most common cause of insert bosses stripping out.
- **Bed release.** PETG bonds hard to smooth PEI and can tear the sheet. Use a
  textured sheet, or a glue-stick release layer on smooth. The two large flat
  parts (`side_panel`, `base_plate`) are where this bites.
- **Heat-set inserts:** iron at 250 °C. PETG is much more forgiving than PLA here.
- **Torque:** snug, not hard. PETG takes real preload far better than PLA, but the
  M5 ligament is still only 3.5 mm of plastic.

**If the pack will live in a hot car or in direct desert sun, PETG is not the
right answer** — it softens from about 80 °C and a dark pack in full sun can pass
that. ASA is the correct material for that duty, but it wants an enclosure and it
warps: the 164 mm `side_panel` is right at the limit of what an unenclosed Mini
will hold flat. If you go that route, print the panels first and check them on a
surface plate before committing to the rest.

#### PrusaSlicer 2.9.6 — PETG production profile (Prusa Mini, 0.4 mm nozzle)

Start from **`0.20mm STRUCTURAL @MINI`**, switch to **Expert** mode, change the
values below, then _Save Print Settings as_ **`MANPACK PETG 0.20 @MINI`**.

STRUCTURAL is the right base here rather than a SPEED or DETAIL preset: it already
biases toward perimeters and slower, more solid extrusion, which is exactly what a
frame whose every load path is a bolt-in-a-counterbore or an insert-in-a-boss
wants (Overview note 1). Set the values below explicitly anyway, so the profile is
deterministic no matter what the base preset ships with. If you prefer a finer
finish, `0.15mm STRUCTURAL @MINI` works identically — just leave _Layer height_ at
0.15 and expect roughly a third more print time.

| Page                  | Setting                       | Value                                   |
| --------------------- | ----------------------------- | --------------------------------------- |
| Layers and perimeters | Layer height                  | **0.20**                                |
| Layers and perimeters | First layer height            | **0.20**                                |
| Layers and perimeters | Perimeters                    | **4**                                   |
| Layers and perimeters | Top solid layers              | **5**                                   |
| Layers and perimeters | Bottom solid layers           | **5**                                   |
| Layers and perimeters | Perimeter generator           | Arachne                                 |
| Layers and perimeters | Detect bridging perimeters    | ✔                                       |
| Layers and perimeters | Thick bridges                 | ✘ unchecked                             |
| Layers and perimeters | Seam position                 | Aligned                                 |
| Layers and perimeters | External perimeters first     | ✘ unchecked                             |
| Infill                | Fill density                  | **40 %**                                |
| Infill                | Fill pattern                  | Gyroid                                  |
| Infill                | Top / Bottom fill pattern     | Monotonic                               |
| Infill                | Combine infill every          | 1                                       |
| Infill                | Infill/perimeters overlap     | 25 %                                    |
| Skirt and brim        | Brim type                     | Outer brim only                         |
| Skirt and brim        | Brim width                    | **5 mm** (crossbeam plate only, else 0) |
| Skirt and brim        | Brim separation gap           | 0.1 mm                                  |
| Support material      | Generate support material     | ✘ unchecked — **except `battery_box` and `compute_box_inline`**, see the modifier table |
| Speed                 | Perimeters                    | **45 mm/s**                             |
| Speed                 | Small perimeters              | **25 mm/s**                             |
| Speed                 | External perimeters           | **25 mm/s**                             |
| Speed                 | Infill                        | 60 mm/s                                 |
| Speed                 | Solid infill                  | 50 mm/s                                 |
| Speed                 | Top solid infill              | 30 mm/s                                 |
| Speed                 | Bridges                       | **25 mm/s**                             |
| Advanced              | Extrusion width — Default     | 0.45 mm                                 |
| Advanced              | Extrusion width — First layer | 0.42 mm                                 |
| Advanced              | Extrusion width — Ext. perim. | 0.42 mm                                 |
| Advanced              | XY size compensation          | **0**                                   |
| Advanced              | Elephant foot compensation    | 0.2 mm                                  |

Leaving _XY size compensation_ at 0 is deliberate: it would shift the Ø5.7 insert
pockets and the Ø4.4 bolt holes together, and those two want opposite corrections.
Trim the pockets in the .scad (`m4_ins_d`) after the coupon print instead.

**Filament Settings — a separate profile from Print Settings.** Start from
`Prusament PETG`, save as **`MANPACK PETG @MINI`**:

| Page     | Setting                                | Value                |
| -------- | -------------------------------------- | -------------------- |
| Filament | Nozzle temperature, other layers       | **240 °C**           |
| Filament | Nozzle temperature, first layer        | **240 °C**           |
| Filament | Bed temperature, first layer           | **85 °C**            |
| Filament | Bed temperature, other layers          | **90 °C**            |
| Cooling  | Keep fan always on                     | ✔                    |
| Cooling  | Min fan speed                          | **30 %**             |
| Cooling  | Max fan speed                          | **50 %**             |
| Cooling  | Bridges fan speed                      | **50 %** (not 100 %) |
| Cooling  | Disable fan for the first              | 1 layer              |
| Cooling  | Slow down if layer print time is below | 15 s                 |
| Cooling  | Min print speed                        | 15 mm/s              |
| Filament | Wipe while retracting (Overrides)      | ✔ (PETG stringing)   |

Holding _Bridges fan speed_ to 50 % is the one non-obvious entry. The stock PETG
profile spikes it to 100 %, and the bridges on this frame are not cosmetic — the
four Ø8.2 mm ceilings in `side_panel` are the bearing surfaces the handle bolt
heads pull against, and blasting them with cold air is exactly how you get a weak
inter-layer bond at a load-bearing face.

#### Per-object modifiers (both profiles)

Two settings are best applied per object rather than globally. Right-click the
object in the 3D view → _Add settings_.

| Object          | Modifier                                                | Why                                                                                                                                                                                                                            |
| --------------- | ------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `side_panel` ×2 | **Height range modifier, 0 → 4 mm, Fill density 100 %** | Guarantees the 3.5 mm ligament under the M5 recess is fully solid. At 0.20 mm that band is ~17 layers, so 5 top + 5 bottom solid layers would otherwise leave ~7 layers of _infill_ inside the one feature carrying the radio. |
| `crossbeam` ×4  | _Layers and perimeters → Perimeters_ = **5**            | Lets the beams run 5 perimeters on a plate sliced with the global 4, without a second profile.                                                                                                                                 |
| `battery_box`   | **Support material = on, _Support on build plate only_ = OFF** | The two front tabs start 54 mm up with 385 mm² in mid-air (§2.9). Build-plate-only support will not generate here — the column has to stand on the **back tab**, not the bed. |
| `compute_box_inline` | **Support material = on**                          | ~13 000 mm² of floor lands over four feet (§12). Only the first 8 mm needs it. |

The height range modifier is the precise fix and costs almost nothing — 4 mm of a
9 mm plate. Setting the whole panel to 100 % infill also works but roughly doubles
its mass, and there are two of them.

**Two objects need support, and only these two.** Turn it on per object rather than
globally — every other part on the frame is self-supporting in its pose, and a
global setting will put scaffolding inside the beams' insert pockets and the
panels' counterbores for nothing.

#### Plate layout (Prusa Mini, 180 × 180 mm)

Five plates cover the frame and battery box. A compute module adds one more plate
for either front variant, or **two** for the inline box. Footprints verified
against the bed:

| Plate | Contents                                     | Footprint    | Margin      |
| ----- | -------------------------------------------- | ------------ | ----------- |
| 1     | 1 × `side_panel`                             | 175 × 70 mm  | **5** / 110 mm |
| 2     | 1 × `side_panel` (the second one)            | 175 × 70 mm  | **5** / 110 mm |
| 3     | 4 × `crossbeam`, stacked in Y, 5 mm brim     | 134 × 122 mm | 46 / 58 mm  |
| 4     | 2 × `antenna_mount` (the base plate is gone) | 35 × 48 mm   | 145 / 132 mm |
| 5     | `battery_box` (**not optional** — §2.9)      | 143 × **75.8** mm | 37 / 104 mm |
| 6     | `compute_box_front` + its cover, side by side | 150 × 160 mm | 30 / 20 mm (box is 40 tall in this pose) |
| 7a    | `compute_box_inline` (only if you build it)  | 143 × 100 mm | 37 / 80 mm  |
| 7b    | `compute_box_inline_cover`                   | 143 × 100 mm | 37 / 80 mm  |

The inline box needs **two plates of its own** — tray and cover are both
143 × 100, and neither pairing fits (286 mm side by side, 200 mm stacked). If you
build it, plate 4 loses the base plate and carries only the two antenna mounts.

**The side panels get a plate each.** Two of them stacked in Y would be
175 × 146 mm, which fits, but at 5 mm of X margin there is no room for a skirt and
no tolerance for bed-origin error on a part that takes over two hours. One per
plate is the safer call. There is no separate handle plate any more — the handles
are part of these panels.

The two panels are _identical_, not mirrored, so both come off the same STL.

> **On preset and setting names.** The two system presets named above
> (`0.20mm SPEED @MINI`, `0.20mm STRUCTURAL @MINI`) were confirmed against an
> actual PrusaSlicer 2.9.6 install, whose Mini system presets are: 0.10mm FAST
> DETAIL, 0.15mm SPEED, 0.15mm STRUCTURAL, 0.20mm SPEED, 0.20mm STRUCTURAL. Older
> Prusa profile bundles used QUALITY/DRAFT naming instead, so if you sync a
> different bundle version the names may shift again — pick the preset at the
> nearest layer height and let the tables govern. The individual _setting_ labels
> are from PrusaSlicer 2.9.x Expert mode but have not each been clicked through;
> if one reads differently, the value still applies.

# Resources

- MakerWorld
  - [4x4_Fam - RT-95 Manpack Rails and BNC bulkhead antenna mount](https://makerworld.com/en/models/1117937-rt-95-manpack-rails-and-bnc-bulkhead-antenna-mount?from=search#profileId-1115768)
  - [El Guardo - ManPack Retevis RT95 / Anytone AT778 UV](https://makerworld.com/en/models/2820039-manpack-retevis-rt95-anytone-at778-uv#profileId-3140415)
