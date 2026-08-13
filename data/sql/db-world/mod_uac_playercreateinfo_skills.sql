-- mod-uac: playercreateinfo_skills for gear-required proficiencies on new combos
-- Gear-derived with reference weapon-skill sanity check; skips stock-covered skills.

-- reapply-safe: clear rows tagged with the mod-uac comment before insert
DELETE FROM `playercreateinfo_skills` WHERE `comment` = 'mod-uac: starter gear skill';

INSERT INTO `playercreateinfo_skills` (`raceMask`, `classMask`, `skill`, `rank`, `comment`) VALUES (1, 4, 46, 0, 'mod-uac: starter gear skill');
INSERT INTO `playercreateinfo_skills` (`raceMask`, `classMask`, `skill`, `rank`, `comment`) VALUES (8, 2, 160, 0, 'mod-uac: starter gear skill');
INSERT INTO `playercreateinfo_skills` (`raceMask`, `classMask`, `skill`, `rank`, `comment`) VALUES (16, 4, 45, 0, 'mod-uac: starter gear skill');
INSERT INTO `playercreateinfo_skills` (`raceMask`, `classMask`, `skill`, `rank`, `comment`) VALUES (32, 8, 173, 0, 'mod-uac: starter gear skill');
INSERT INTO `playercreateinfo_skills` (`raceMask`, `classMask`, `skill`, `rank`, `comment`) VALUES (64, 2, 160, 0, 'mod-uac: starter gear skill');
INSERT INTO `playercreateinfo_skills` (`raceMask`, `classMask`, `skill`, `rank`, `comment`) VALUES (64, 4, 46, 0, 'mod-uac: starter gear skill');
INSERT INTO `playercreateinfo_skills` (`raceMask`, `classMask`, `skill`, `rank`, `comment`) VALUES (1024, 8, 173, 0, 'mod-uac: starter gear skill');

-- Rykaerdoe fork: fix combos that got a weapon item but no matching skill grant.
-- The generator's "skip if stock-covered" check treats any existing row for
-- (skill, class) as full coverage, even when that row's raceMask excludes the
-- specific new-combo race that received the cloned weapon. (Blood Elf Warrior 2H Axe,
-- Human/Undead/Gnome Hunter 2H Axe, Orc/Tauren/Gnome Priest Staves,
-- Dwarf/NightElf/Tauren/Troll/Draenei Warlock Staves — all missing coverage
-- despite being cloned a weapon requiring that skill).

-- New grants (no pre-existing row to widen) — reapply-safe, tagged like the rest of this file.
DELETE FROM `playercreateinfo_skills` WHERE `comment` = 'mod-uac: starter gear skill (rykaerdoe fix)';
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`, `classMask`, `skill`, `rank`, `comment`) VALUES (81,   4,   172, 0, 'mod-uac: starter gear skill (rykaerdoe fix)');
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`, `classMask`, `skill`, `rank`, `comment`) VALUES (98,   16,  136, 0, 'mod-uac: starter gear skill (rykaerdoe fix)');
INSERT IGNORE INTO `playercreateinfo_skills` (`raceMask`, `classMask`, `skill`, `rank`, `comment`) VALUES (1196, 256, 136, 0, 'mod-uac: starter gear skill (rykaerdoe fix)');

-- Widen existing narrow stock rows to include new-combo races that were
-- cloned a matching weapon but excluded from the pre-existing skill mask.
-- Idempotent: matches only the original narrow value, so re-running is a no-op.
UPDATE `playercreateinfo_skills` SET `raceMask` = 518 WHERE `skill` = 172 AND `classMask` = 1   AND `raceMask` = 6;   -- Warrior Two-Handed Axes: + Blood Elf
UPDATE `playercreateinfo_skills` SET `raceMask` = 690 WHERE `skill` = 55  AND `classMask` = 2   AND `raceMask` = 512; -- Paladin Two-Handed Swords: + Orc/Undead/Tauren/Troll
