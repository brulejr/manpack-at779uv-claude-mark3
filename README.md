# Modular manpack internal frame — Retevis RT-95 / AnyTone AT-779UV

This is a clean-room decomposition of the single-piece reference STL from
[RT-95 Manpack Rails and BNC bulkhead antenna mount](https://makerworld.com/en/models/1117937-rt-95-manpack-rails-and-bnc-bulkhead-antenna-mount?from=search#profileId-1115768) with the following notable changes:

- Separated into nine printable modules, each of which fits a Prusa Mini
  (180 × 180 mm bed).
- Every module-to-module joint uses stainless M4 socket-cap bolts into brass heat-set inserts.
- Radio mounts use stainless M5 bolts or factory thumb screws.
- Frame base allows additional modules to be connected such as battery frame or compute box.

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

| #   | Part                     | Qty | Print size (mm)  | Solid vol | Inserts |
| --- | ------------------------ | --- | ---------------- | --------- | ------- |
| 1   | `side_panel`             | 2   | 164 × 70 × 9     | 81.9 cm³  | —       |
| 2   | `crossbeam_top_front`    | 1   | 124.25 × 16 × 24 | 44.5 cm³  | 12      |
| 3   | `crossbeam_top_back`     | 1   | 124.25 × 16 × 24 | 46.3 cm³  | 4       |
| 4   | `crossbeam_bottom_front` | 1   | 124.25 × 16 × 24 | 45.9 cm³  | 6       |
| 5   | `crossbeam_bottom_back`  | 1   | 124.25 × 16 × 24 | 45.9 cm³  | 6       |
| 6   | `handle`                 | 2   | 78 × 70 × 12     | 37.6 cm³  | 4 each  |
| 7   | `antenna_mount`          | 2   | 35 × 24 × 33     | 12.3 cm³  | —       |
| 8   | `base_plate`             | 1   | 142.25 × 70 × 18 | 83.4 cm³  | 4       |

Largest part is 164 mm — **16 mm of bed margin**. All eight meshes verified
watertight, single-shell, and bed-legal.

Solid volume for a full set is 398 cm³ (one of each) / 530 cm³ (all 11 pieces).
Actual filament use is far lower — the beams are small enough in section that
the slicer's perimeters and infill dominate. If mass matters, the base plate is
the obvious place to add a lightening window.

### 1 — `side_panel` ×2

A plain flat plate. It carries **only** the ported radio mount plus through-holes
for the beams and handle. No feet, no handle, no antenna mount, and **no heat-set
inserts at all** — every insert lives in the mating part, which is what keeps
this a simple flat print.

- Radio mount: Ø5.000 through-hole at (Y 35, Z 98) with the Ø26.468 × 5.5 mm
  outer-face recess, both verbatim from the reference.
- 8 × M4 clearance holes, heads counterbored flush in the **outer** face → the
  four crossbeams.
- 4 × M4 clearance holes, heads counterbored flush in the **inner** face → the
  handle. Flush heads keep the radio bay clear.
- Two lightening/ventilation windows, positioned to leave ≥ 10.8 mm of material
  between them and the M5 recess ligament. Set `panel_windows = false` for a
  plain plate.

### 2–5 — `crossbeam` ×4

Four beams instead of the reference's two, front and back at top and bottom,
forming a closed box. Each spans the full 124.25 mm between the panel inner
faces, with **two axial M4 inserts per end** stacked vertically so the joint
cannot rotate about a single bolt.

Extra insert faces by position:

- `crossbeam_top_front` — 8 inserts in its **front face** for the two antenna
  mounts.
- `crossbeam_bottom_front` / `_bottom_back` — 2 inserts each in their
  **undersides** for the base plate.

### 6 — `handle` ×2

The reference grip loop ported as a separate inverted-U: same **33.75 × 18.5 mm**
hand aperture and **11.5 mm** grip bar. It laps 48 mm down the panel's outer face
on four M4 bolts. The aperture sits above the panel's top edge, so the panel's
own top edge forms the aperture floor exactly as it did in the reference — the
grip geometry your hand meets is unchanged.

### 7 — `antenna_mount` ×2

The reference ear, made modular: Ø12.468 hole, 3.75 mm pad, 25 mm forward reach,
hole 12.66 mm back from the pad tip, and the diagonal gusset. Bolts to the
**front face of the top-front crossbeam** on four M4 bolts. Verified: Ø17 × 22 mm
of clear bore below each pad for the connector nut and washer, and clear whip
space above.

### 8 — `base_plate`

The modular bottom interface. Bolts up into the two bottom crossbeams on four
M4 bolts. Its **four bosses are simultaneously the frame's feet and the M4
attachment grid** that future modules (battery, tuner, ATU) bolt up into — one
feature doing both jobs, so nothing else needs to hang off the frame.

Its top face is deliberately left flat. An earlier revision had two raised
locating lips for the panel bottom edges; they made the part unprintable (see
§9), and since the panels are located by their 16 bolts into the crossbeams, the
lips were redundant.

---

## 3. Deliberate deviations from the reference

These are engineering necessities, not preferences. Each is a parameter.

| Change               | From                      | To                                 | Why                                                                                                                                                                                                                               |
| -------------------- | ------------------------- | ---------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Crossbeam section    | 7 × 4 mm                  | **16 × 24 mm**                     | An M4 heat-set insert needs a Ø5.7 × 9 mm pocket. It physically cannot fit in a 7 × 4 mm beam. This is the direct cost of the M4-bolted requirement.                                                                              |
| Frame depth          | 60 mm                     | **70 mm**                          | With four beams instead of two, front beams now exist at the top. At 60 mm deep they would overhang the radio's upward-facing control panel by 12 mm per side. At 70 mm the overhang is **zero** — verified in `img/asm_top.png`. |
| Panel thickness      | 8.25 mm                   | **9.0 mm**                         | Leaves 5.0 mm under an M4 counterbore and 3.5 mm under the M5 recess (reference: 2.75 mm).                                                                                                                                        |
| Antenna gusset       | one rib in the rail plane | **two ribs, one per bracket edge** | A bolt-on bracket has no rail plane to hide the rib in. Duplicating it onto both edges keeps the bore under the hole clear and makes the bracket symmetric.                                                                       |
| Antenna hole spacing | 101.5 mm                  | **89.25 mm**                       | Consequence of the above: the hole moves to the bracket centre, between the two ribs.                                                                                                                                             |
| Handle thickness     | 8.25 mm                   | **12 mm**                          | Needed to seat an axial M4 insert. Slightly chunkier grip bar; the aperture is unchanged.                                                                                                                                         |
| Leg standoff         | 45 mm of integral leg     | **18 mm base plate**               | That 45 mm of dead space is now where a bolt-on module goes.                                                                                                                                                                      |

Unchanged on purpose: inner span 124.25 mm, M5 hole Ø5.000 at the bay centre,
Ø26.468 × 5.5 recess, Ø12.468 antenna hole, 3.75 mm pad, 25 mm reach, 12.66 mm
setback, 33.75 × 18.5 aperture, 11.5 mm grip bar.

**Dropped:** the reference's back stiffener fins and the rail tying the two
antenna ears. Both existed to stiffen a two-beam frame; the four-beam box makes
them redundant.

---

## 4. Hardware

All bolts stainless, socket cap. All inserts brass M4, 6.0 mm OD × 8.0 mm long
(Ruthex/Bumat type) — the pockets are Ø5.7 × 9.0 mm with a Ø6.6 lead-in chamfer.

| Joint                           | Bolt           | Qty                      | Insert lives in                     |
| ------------------------------- | -------------- | ------------------------ | ----------------------------------- |
| Side panels → 4 crossbeams      | M4 × 12        | 16                       | crossbeam ends                      |
| Side panels → handles           | M4 × 12        | 8                        | handle legs                         |
| Antenna mounts → top-front beam | M4 × 12        | 8                        | top-front beam front face           |
| Base plate → bottom beams       | M4 × 12        | 4                        | bottom beam undersides              |
| Future module → base plate      | M4 × (module)  | 4                        | base plate feet                     |
| **Radio → side panels**         | **M5 × 10–12** | **2**                    | the radio's own threaded side holes |
|                                 | **M4 total**   | **36 bolts, 40 inserts** |                                     |

M4 × 12 is correct throughout: 4.0 mm counterbore, plus 5.0 mm of remaining
panel, plus 7.0 mm of thread engagement, against a 9.0 mm pocket. Do not fit
longer bolts — M4 × 16 bottoms out.

Check the M5 length against your radio's actual side-hole thread depth. With the
head seated 5.5 mm down in the recess, an M5 × 12 gives 3.5 mm through the panel
and 8.5 mm into the radio.

---

## 5. Printing

| Part            | Orientation                        | Notes                                                                             |
| --------------- | ---------------------------------- | --------------------------------------------------------------------------------- |
| `side_panel`    | flat, **inner** face down          | M5 recess and all 8 beam counterbores open upward; only 4 × Ø8.2 bridges          |
| `crossbeam` ×4  | long axis on the bed, 24 mm tall   | end **and** front-face inserts both come out in-plane                             |
| `handle`        | flat, mating face down             | one bridge over the grip aperture; flattest face becomes the lap joint            |
| `antenna_mount` | on its back                        | every layer smaller than the one below — no supports                              |
| `base_plate`    | upside down, flat top face on bed  | feet and every insert mouth point upward; fully self-supporting                    |

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

Order matters in one place: the handle lap pads cover the top crossbeam bolt
heads, so the top beams go on first.

1. Heat all 40 inserts. Beam ends first — check the two per end are square, or
   the panel will not sit flat.
2. Bolt the four crossbeams to one side panel (16 × M4 × 12, heads on the
   **outside**). Add the second panel.
3. Bolt the base plate up into the two bottom beams (4 × M4 × 12). Its locating
   lips should capture both panel bottom edges.
4. Drop the radio in and fit the two M5 bolts through the panel recesses into
   the radio's side holes.
5. Bolt on the two handles (8 × M4 × 12, heads on the **inside**, flush).
6. Bolt on the two antenna mounts (8 × M4 × 12), then fit the antenna
   connectors.

---

## 7. Verification performed

Not just rendered — checked:

- All 8 meshes watertight, **single connected shell**, within 180 × 180.
  (This caught two real defects: the antenna gusset and the base-plate locating
  lips initially only touched their neighbours on a coplanar face, producing
  two- and three-shell parts.)
- **Zero interference** across all 66 pairs of parts in assembled position,
  including the radio envelope.
- **All 36 M4 bolt axes and both M5 axes** traced: each passes through a
  clearance hole in one part and lands inside the insert pocket of the other,
  with no material fouling the shank.
- Antenna bore: Ø17 × 22 mm clear below each pad, Ø20 × 40 mm clear above.
- **Per-layer cross-sectional area of every shipped STL in its print pose**, to
  find material laid over voids. This caught two real orientation defects: the
  base plate printing 98 % in mid-air on two locating lips, and the side panel
  bridging a Ø26.5 mm ceiling directly under the ligament that carries the
  radio. Both are fixed; no part now needs supports.
- Asserts in the model fail the render if the panel exceeds the bed, the beam
  span exceeds the bed, `frame_d` is too small to clear the control panel,
  `bay_h` is too small for the radio, or the M5 recess leaves < 3 mm of panel.

Reported clearances at the shipped parameters:

```
frame body            = 142.25 x 70 x 180 mm
assembled envelope    = 166.25 x 103 x 210 mm
radio bay (WxDxH)     = 124.25 x 38 x 116 mm
radio clearance  side = 1 mm/side   above/below = 7.5 mm
panel print footprint = 164 x 70  (bed 180) -> margin 16 mm
panel under M5 recess = 3.5 mm of material carrying the radio
```

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

5. The Ø26.468 × 5.5 mm recess is reproduced because the brief says to transfer
   the radio mounts, but its purpose is inferred: it is far too large for an M5
   head, so it is almost certainly a seat for the OEM knurled mounting knob. If
   you are using plain M5 socket caps, it can shrink to Ø10 and reclaim 2 mm of
   panel thickness under the bolt.

---

## 9. Print settings

### Overview

Slice `stl/*.stl` as-is. Every part is already in its recommended pose (§5) and
**no part on this frame needs supports** — the only ceilings anywhere are the
tops of insert pockets and bolt bores, the largest of which is the Ø12.468 mm
antenna bore through a 3.75 mm wall. Verified by measuring per-layer
cross-sectional area on all eight meshes; the biggest single unsupported area on
any layer is about 93 mm².

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
   3.5 mm — about 17 layers at 0.2 mm. With a slicer default of 4 top / 4 bottom
   solid layers, the middle of the one feature carrying the radio would be
   *infill*. Run the side panels at **6 top / 6 bottom** (or simply 100 % infill,
   they are thin parts).
3. **The M4 counterbore is 4.0 mm deep for a 4.0 mm head — zero margin.** If your
   first layer is over-squished or elephant-foot compensation is set aggressively,
   heads will sit proud. This specifically matters at the four top-crossbeam
   bolts, because the handle lap pads seat directly on top of them: one proud head
   there and the handle rocks. Check with a straightedge before fitting handles.
4. **Ø8.2 mm counterbores will not accept an M4 washer** (≈Ø9 mm OD). Run the M4
   bolts bare. The M5 recess has room for a washer if you want one.
5. **Print one crossbeam first as a coupon.** `crossbeam_top_front` carries 12 of
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

| Setting            | Value                                                       |
| ------------------ | ----------------------------------------------------------- |
| Nozzle / layer     | 0.4 mm / **0.25 mm** (0.20 mm for the side panels)          |
| Perimeters         | 2                                                           |
| Top / bottom solid | 4 / 4 — but **6 / 6 on `side_panel`** (see Overview note 2) |
| Infill             | 15 % gyroid                                                 |
| Nozzle temp        | 215 °C (first layer 215 °C)                                 |
| Bed temp           | 60 °C                                                       |
| Cooling            | 100 %                                                       |
| Brim               | 5 mm on the four crossbeams; none needed elsewhere          |
| Supports           | none                                                        |

Why a brim only on the crossbeams: their footprint is 124 × 16 mm and they stand
24 mm tall, so they are the one narrow, tippy part in the set. Everything else
has a large flat first layer (`side_panel` 9714 mm², `base_plate` 9579 mm²).

Use 0.20 mm layers for the side panels even in prototype — the whole point of a
prototype here is checking the M5 hole position and the counterbore depths, and
those measurements shift with layer height.

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

### 9.2 Production / final — PETG

| Setting            | Value                                                        |
| ------------------ | ------------------------------------------------------------ |
| Nozzle / layer     | 0.4 mm / **0.20 mm** (first layer 0.25 mm)                   |
| Perimeters         | **4** — 5 on the four crossbeams                             |
| Top / bottom solid | 5 / 5 — **6 / 6 on `side_panel`**                            |
| Infill             | 40 % gyroid                                                  |
| Nozzle temp        | 240 °C (first layer 245 °C)                                  |
| Bed temp           | 85 °C                                                        |
| Cooling            | **30–50 %**, and do not let bridge/overhang fan spike to 100 % |
| Perimeter speed    | 40–50 mm/s                                                   |
| Brim               | 5 mm on the four crossbeams                                  |
| Supports           | none                                                         |

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
