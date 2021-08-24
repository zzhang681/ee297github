-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 18.1 (Release Build #625)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2018 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from macacc
-- VHDL created on Sun Aug 22 13:12:46 2021


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity macacc is
    port (
        x : in std_logic_vector(31 downto 0);  -- float32_m23
        n : in std_logic_vector(0 downto 0);  -- ufix1
        en : in std_logic_vector(0 downto 0);  -- ufix1
        r : out std_logic_vector(31 downto 0);  -- float32_m23
        xo : out std_logic_vector(0 downto 0);  -- ufix1
        xu : out std_logic_vector(0 downto 0);  -- ufix1
        ao : out std_logic_vector(0 downto 0);  -- ufix1
        clk : in std_logic;
        areset : in std_logic
    );
end macacc;

architecture normal of macacc is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expX_uid6_fpAccTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fracX_uid7_fpAccTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal signX_uid8_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal oFracX_uid10_fpAccTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expLTLSBA_uid11_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cmpLT_expX_expLTLSBA_uid12_fpAccTest_a : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpLT_expX_expLTLSBA_uid12_fpAccTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpLT_expX_expLTLSBA_uid12_fpAccTest_o : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpLT_expX_expLTLSBA_uid12_fpAccTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal expGTMaxMSBX_uid13_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_a : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_o : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal rShiftConstant_uid15_fpAccTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal rightShiftValue_uid16_fpAccTest_a : STD_LOGIC_VECTOR (9 downto 0);
    signal rightShiftValue_uid16_fpAccTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal rightShiftValue_uid16_fpAccTest_o : STD_LOGIC_VECTOR (9 downto 0);
    signal rightShiftValue_uid16_fpAccTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal padConst_uid17_fpAccTest_q : STD_LOGIC_VECTOR (37 downto 0);
    signal rightPaddedIn_uid18_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal shiftedFracUpper_uid20_fpAccTest_b : STD_LOGIC_VECTOR (37 downto 0);
    signal extendedAlignedShiftedFrac_uid21_fpAccTest_q : STD_LOGIC_VECTOR (38 downto 0);
    signal onesComplementExtendedFrac_uid22_fpAccTest_b : STD_LOGIC_VECTOR (38 downto 0);
    signal onesComplementExtendedFrac_uid22_fpAccTest_q : STD_LOGIC_VECTOR (38 downto 0);
    signal accumulator_uid24_fpAccTest_a : STD_LOGIC_VECTOR (50 downto 0);
    signal accumulator_uid24_fpAccTest_b : STD_LOGIC_VECTOR (50 downto 0);
    signal accumulator_uid24_fpAccTest_i : STD_LOGIC_VECTOR (50 downto 0);
    signal accumulator_uid24_fpAccTest_o : STD_LOGIC_VECTOR (50 downto 0);
    signal accumulator_uid24_fpAccTest_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal accumulator_uid24_fpAccTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal accumulator_uid24_fpAccTest_q : STD_LOGIC_VECTOR (48 downto 0);
    signal os_uid25_fpAccTest_q : STD_LOGIC_VECTOR (49 downto 0);
    signal osr_uid26_fpAccTest_in : STD_LOGIC_VECTOR (48 downto 0);
    signal osr_uid26_fpAccTest_b : STD_LOGIC_VECTOR (48 downto 0);
    signal sum_uid27_fpAccTest_in : STD_LOGIC_VECTOR (47 downto 0);
    signal sum_uid27_fpAccTest_b : STD_LOGIC_VECTOR (47 downto 0);
    signal accumulatorSign_uid29_fpAccTest_in : STD_LOGIC_VECTOR (46 downto 0);
    signal accumulatorSign_uid29_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal accOverflowBitMSB_uid30_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal accOverflow_uid32_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal accValidRange_uid33_fpAccTest_in : STD_LOGIC_VECTOR (46 downto 0);
    signal accValidRange_uid33_fpAccTest_b : STD_LOGIC_VECTOR (46 downto 0);
    signal accOnesComplement_uid34_fpAccTest_b : STD_LOGIC_VECTOR (46 downto 0);
    signal accOnesComplement_uid34_fpAccTest_q : STD_LOGIC_VECTOR (46 downto 0);
    signal accValuePositive_uid35_fpAccTest_a : STD_LOGIC_VECTOR (47 downto 0);
    signal accValuePositive_uid35_fpAccTest_b : STD_LOGIC_VECTOR (47 downto 0);
    signal accValuePositive_uid35_fpAccTest_o : STD_LOGIC_VECTOR (47 downto 0);
    signal accValuePositive_uid35_fpAccTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal posAccWoLeadingZeroBit_uid36_fpAccTest_in : STD_LOGIC_VECTOR (45 downto 0);
    signal posAccWoLeadingZeroBit_uid36_fpAccTest_b : STD_LOGIC_VECTOR (45 downto 0);
    signal ShiftedOutComparator_uid38_fpAccTest_q : STD_LOGIC_VECTOR (5 downto 0);
    signal accResOutOfExpRange_uid39_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expRBias_uid41_fpAccTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal zeroExponent_uid42_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal resExpSub_uid43_fpAccTest_a : STD_LOGIC_VECTOR (9 downto 0);
    signal resExpSub_uid43_fpAccTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal resExpSub_uid43_fpAccTest_o : STD_LOGIC_VECTOR (9 downto 0);
    signal resExpSub_uid43_fpAccTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal finalExponent_uid44_fpAccTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal finalExponent_uid44_fpAccTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal finalExpUpdated_uid45_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal finalExpUpdated_uid45_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fracR_uid46_fpAccTest_in : STD_LOGIC_VECTOR (44 downto 0);
    signal fracR_uid46_fpAccTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal R_uid47_fpAccTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal delayedXOverflowFeedbackSignal_uid50_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal muxXOverflowFeedbackSignal_uid51_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal muxXOverflowFeedbackSignal_uid51_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oRXOverflowFlagFeedback_uid52_fpAccTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal oRXOverflowFlagFeedback_uid52_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal delayedXUnderflowFeedbackSignal_uid54_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal muxXUnderflowFeedbackSignal_uid55_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal muxXUnderflowFeedbackSignal_uid55_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expNotZero_uid56_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal underflowCond_uid57_fpAccTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal underflowCond_uid57_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oRXUnderflowFlagFeedback_uid58_fpAccTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal oRXUnderflowFlagFeedback_uid58_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal delayedAccOverflowFeedbackSignal_uid60_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal muxAccOverflowFeedbackSignal_uid61_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal muxAccOverflowFeedbackSignal_uid61_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oRAccOverflowFlagFeedback_uid62_fpAccTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal oRAccOverflowFlagFeedback_uid62_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal zs_uid66_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal vCount_uid68_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mO_uid69_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (17 downto 0);
    signal cStage_uid71_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal vStagei_uid73_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid73_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal zs_uid74_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid76_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid79_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid79_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid82_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid85_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid85_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zs_uid86_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid88_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid91_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid91_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal zs_uid92_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal vCount_uid94_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid97_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid97_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid99_zeroCounter_uid37_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid100_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid101_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (5 downto 0);
    signal wIntCst_uid105_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (5 downto 0);
    signal shiftedOut_uid106_alignmentShifter_uid17_fpAccTest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftedOut_uid106_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftedOut_uid106_alignmentShifter_uid17_fpAccTest_o : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftedOut_uid106_alignmentShifter_uid17_fpAccTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng8_uid107_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (53 downto 0);
    signal rightShiftStage0Idx1_uid109_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage0Idx2Rng16_uid110_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (45 downto 0);
    signal rightShiftStage0Idx2_uid112_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage0Idx3Rng24_uid113_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (37 downto 0);
    signal rightShiftStage0Idx3Pad24_uid114_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal rightShiftStage0Idx3_uid115_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage0Idx4Rng32_uid116_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (29 downto 0);
    signal rightShiftStage0Idx4_uid118_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage0Idx5Rng40_uid119_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (21 downto 0);
    signal rightShiftStage0Idx5Pad40_uid120_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (39 downto 0);
    signal rightShiftStage0Idx5_uid121_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage0Idx6Rng48_uid122_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (13 downto 0);
    signal rightShiftStage0Idx6Pad48_uid123_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage0Idx6_uid124_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage0Idx7Rng56_uid125_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStage0Idx7Pad56_uid126_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (55 downto 0);
    signal rightShiftStage0Idx7_uid127_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage1Idx1Rng1_uid130_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (60 downto 0);
    signal rightShiftStage1Idx1_uid132_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage1Idx2Rng2_uid133_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (59 downto 0);
    signal rightShiftStage1Idx2_uid135_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage1Idx3Rng3_uid136_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (58 downto 0);
    signal rightShiftStage1Idx3Pad3_uid137_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStage1Idx3_uid138_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage1Idx4Rng4_uid139_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (57 downto 0);
    signal rightShiftStage1Idx4_uid141_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage1Idx5Rng5_uid142_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (56 downto 0);
    signal rightShiftStage1Idx5Pad5_uid143_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (4 downto 0);
    signal rightShiftStage1Idx5_uid144_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage1Idx6Rng6_uid145_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (55 downto 0);
    signal rightShiftStage1Idx6Pad6_uid146_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStage1Idx6_uid147_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage1Idx7Rng7_uid148_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (54 downto 0);
    signal rightShiftStage1Idx7Pad7_uid149_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (6 downto 0);
    signal rightShiftStage1Idx7_uid150_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal zeroOutCst_uid153_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal r_uid154_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid154_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (61 downto 0);
    signal leftShiftStage0Idx1Rng8_uid159_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (39 downto 0);
    signal leftShiftStage0Idx1Rng8_uid159_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (39 downto 0);
    signal leftShiftStage0Idx1_uid160_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage0Idx2Rng16_uid162_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage0Idx2Rng16_uid162_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (31 downto 0);
    signal leftShiftStage0Idx2_uid163_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage0Idx3Rng24_uid165_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage0Idx3Rng24_uid165_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage0Idx3_uid166_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage0Idx4Rng32_uid168_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage0Idx4Rng32_uid168_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage0Idx4_uid169_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage0Idx5Rng40_uid171_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal leftShiftStage0Idx5Rng40_uid171_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal leftShiftStage0Idx5_uid172_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage1Idx1Rng1_uid178_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (46 downto 0);
    signal leftShiftStage1Idx1Rng1_uid178_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (46 downto 0);
    signal leftShiftStage1Idx1_uid179_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage1Idx2Rng2_uid181_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (45 downto 0);
    signal leftShiftStage1Idx2Rng2_uid181_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (45 downto 0);
    signal leftShiftStage1Idx2_uid182_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage1Idx3Rng3_uid184_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (44 downto 0);
    signal leftShiftStage1Idx3Rng3_uid184_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (44 downto 0);
    signal leftShiftStage1Idx3_uid185_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage1Idx4Rng4_uid187_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (43 downto 0);
    signal leftShiftStage1Idx4Rng4_uid187_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (43 downto 0);
    signal leftShiftStage1Idx4_uid188_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage1Idx5Rng5_uid190_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (42 downto 0);
    signal leftShiftStage1Idx5Rng5_uid190_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (42 downto 0);
    signal leftShiftStage1Idx5_uid191_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage1Idx6Rng6_uid193_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (41 downto 0);
    signal leftShiftStage1Idx6Rng6_uid193_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (41 downto 0);
    signal leftShiftStage1Idx6_uid194_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage1Idx7Rng7_uid196_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (40 downto 0);
    signal leftShiftStage1Idx7Rng7_uid196_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (40 downto 0);
    signal leftShiftStage1Idx7_uid197_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_0_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_0_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_1_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_1_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_0_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_0_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_1_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_1_q : STD_LOGIC_VECTOR (61 downto 0);
    signal rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_mfinal_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_mfinal_q : STD_LOGIC_VECTOR (61 downto 0);
    signal leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_0_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_0_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_1_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_1_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_0_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_0_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_1_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_1_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_mfinal_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_mfinal_q : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStageSel5Dto3_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_in : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStageSel5Dto3_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStageSel5Dto3_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (2 downto 0);
    signal rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (31 downto 0);
    signal rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (13 downto 0);
    signal rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel5Dto3_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (2 downto 0);
    signal leftShiftStageSel5Dto3_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_vCount_uid76_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_vCount_uid68_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_underflowCond_uid57_fpAccTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_accValuePositive_uid35_fpAccTest_q_2_q : STD_LOGIC_VECTOR (47 downto 0);
    signal redist8_accumulatorSign_uid29_fpAccTest_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_shiftedFracUpper_uid20_fpAccTest_b_1_q : STD_LOGIC_VECTOR (37 downto 0);
    signal redist10_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist11_signX_uid8_fpAccTest_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_xIn_n_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_xIn_n_2_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- signX_uid8_fpAccTest(BITSELECT,7)@0
    signX_uid8_fpAccTest_b <= STD_LOGIC_VECTOR(x(31 downto 31));

    -- redist11_signX_uid8_fpAccTest_b_1(DELAY,242)
    redist11_signX_uid8_fpAccTest_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signX_uid8_fpAccTest_b, xout => redist11_signX_uid8_fpAccTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- redist12_xIn_n_1(DELAY,243)
    redist12_xIn_n_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => n, xout => redist12_xIn_n_1_q, ena => en(0), clk => clk, aclr => areset );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- zeroOutCst_uid153_alignmentShifter_uid17_fpAccTest(CONSTANT,152)
    zeroOutCst_uid153_alignmentShifter_uid17_fpAccTest_q <= "00000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage1Idx7Pad7_uid149_alignmentShifter_uid17_fpAccTest(CONSTANT,148)
    rightShiftStage1Idx7Pad7_uid149_alignmentShifter_uid17_fpAccTest_q <= "0000000";

    -- rightShiftStage0Idx7Pad56_uid126_alignmentShifter_uid17_fpAccTest(CONSTANT,125)
    rightShiftStage0Idx7Pad56_uid126_alignmentShifter_uid17_fpAccTest_q <= "00000000000000000000000000000000000000000000000000000000";

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- fracX_uid7_fpAccTest(BITSELECT,6)@0
    fracX_uid7_fpAccTest_b <= x(22 downto 0);

    -- oFracX_uid10_fpAccTest(BITJOIN,9)@0
    oFracX_uid10_fpAccTest_q <= VCC_q & fracX_uid7_fpAccTest_b;

    -- padConst_uid17_fpAccTest(CONSTANT,16)
    padConst_uid17_fpAccTest_q <= "00000000000000000000000000000000000000";

    -- rightPaddedIn_uid18_fpAccTest(BITJOIN,17)@0
    rightPaddedIn_uid18_fpAccTest_q <= oFracX_uid10_fpAccTest_q & padConst_uid17_fpAccTest_q;

    -- rightShiftStage0Idx7Rng56_uid125_alignmentShifter_uid17_fpAccTest(BITSELECT,124)@0
    rightShiftStage0Idx7Rng56_uid125_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(61 downto 56);

    -- rightShiftStage0Idx7_uid127_alignmentShifter_uid17_fpAccTest(BITJOIN,126)@0
    rightShiftStage0Idx7_uid127_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx7Pad56_uid126_alignmentShifter_uid17_fpAccTest_q & rightShiftStage0Idx7Rng56_uid125_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage0Idx6Pad48_uid123_alignmentShifter_uid17_fpAccTest(CONSTANT,122)
    rightShiftStage0Idx6Pad48_uid123_alignmentShifter_uid17_fpAccTest_q <= "000000000000000000000000000000000000000000000000";

    -- rightShiftStage0Idx6Rng48_uid122_alignmentShifter_uid17_fpAccTest(BITSELECT,121)@0
    rightShiftStage0Idx6Rng48_uid122_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(61 downto 48);

    -- rightShiftStage0Idx6_uid124_alignmentShifter_uid17_fpAccTest(BITJOIN,123)@0
    rightShiftStage0Idx6_uid124_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx6Pad48_uid123_alignmentShifter_uid17_fpAccTest_q & rightShiftStage0Idx6Rng48_uid122_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage0Idx5Pad40_uid120_alignmentShifter_uid17_fpAccTest(CONSTANT,119)
    rightShiftStage0Idx5Pad40_uid120_alignmentShifter_uid17_fpAccTest_q <= "0000000000000000000000000000000000000000";

    -- rightShiftStage0Idx5Rng40_uid119_alignmentShifter_uid17_fpAccTest(BITSELECT,118)@0
    rightShiftStage0Idx5Rng40_uid119_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(61 downto 40);

    -- rightShiftStage0Idx5_uid121_alignmentShifter_uid17_fpAccTest(BITJOIN,120)@0
    rightShiftStage0Idx5_uid121_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx5Pad40_uid120_alignmentShifter_uid17_fpAccTest_q & rightShiftStage0Idx5Rng40_uid119_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid66_zeroCounter_uid37_fpAccTest(CONSTANT,65)
    zs_uid66_zeroCounter_uid37_fpAccTest_q <= "00000000000000000000000000000000";

    -- rightShiftStage0Idx4Rng32_uid116_alignmentShifter_uid17_fpAccTest(BITSELECT,115)@0
    rightShiftStage0Idx4Rng32_uid116_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(61 downto 32);

    -- rightShiftStage0Idx4_uid118_alignmentShifter_uid17_fpAccTest(BITJOIN,117)@0
    rightShiftStage0Idx4_uid118_alignmentShifter_uid17_fpAccTest_q <= zs_uid66_zeroCounter_uid37_fpAccTest_q & rightShiftStage0Idx4Rng32_uid116_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_1(MUX,203)@0
    rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_1_s <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select_b;
    rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_1_combproc: PROCESS (rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_1_s, en, rightShiftStage0Idx4_uid118_alignmentShifter_uid17_fpAccTest_q, rightShiftStage0Idx5_uid121_alignmentShifter_uid17_fpAccTest_q, rightShiftStage0Idx6_uid124_alignmentShifter_uid17_fpAccTest_q, rightShiftStage0Idx7_uid127_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_1_s) IS
            WHEN "00" => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_1_q <= rightShiftStage0Idx4_uid118_alignmentShifter_uid17_fpAccTest_q;
            WHEN "01" => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_1_q <= rightShiftStage0Idx5_uid121_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_1_q <= rightShiftStage0Idx6_uid124_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_1_q <= rightShiftStage0Idx7_uid127_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_1_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage0Idx3Pad24_uid114_alignmentShifter_uid17_fpAccTest(CONSTANT,113)
    rightShiftStage0Idx3Pad24_uid114_alignmentShifter_uid17_fpAccTest_q <= "000000000000000000000000";

    -- rightShiftStage0Idx3Rng24_uid113_alignmentShifter_uid17_fpAccTest(BITSELECT,112)@0
    rightShiftStage0Idx3Rng24_uid113_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(61 downto 24);

    -- rightShiftStage0Idx3_uid115_alignmentShifter_uid17_fpAccTest(BITJOIN,114)@0
    rightShiftStage0Idx3_uid115_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx3Pad24_uid114_alignmentShifter_uid17_fpAccTest_q & rightShiftStage0Idx3Rng24_uid113_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid74_zeroCounter_uid37_fpAccTest(CONSTANT,73)
    zs_uid74_zeroCounter_uid37_fpAccTest_q <= "0000000000000000";

    -- rightShiftStage0Idx2Rng16_uid110_alignmentShifter_uid17_fpAccTest(BITSELECT,109)@0
    rightShiftStage0Idx2Rng16_uid110_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(61 downto 16);

    -- rightShiftStage0Idx2_uid112_alignmentShifter_uid17_fpAccTest(BITJOIN,111)@0
    rightShiftStage0Idx2_uid112_alignmentShifter_uid17_fpAccTest_q <= zs_uid74_zeroCounter_uid37_fpAccTest_q & rightShiftStage0Idx2Rng16_uid110_alignmentShifter_uid17_fpAccTest_b;

    -- zeroExponent_uid42_fpAccTest(CONSTANT,41)
    zeroExponent_uid42_fpAccTest_q <= "00000000";

    -- rightShiftStage0Idx1Rng8_uid107_alignmentShifter_uid17_fpAccTest(BITSELECT,106)@0
    rightShiftStage0Idx1Rng8_uid107_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(61 downto 8);

    -- rightShiftStage0Idx1_uid109_alignmentShifter_uid17_fpAccTest(BITJOIN,108)@0
    rightShiftStage0Idx1_uid109_alignmentShifter_uid17_fpAccTest_q <= zeroExponent_uid42_fpAccTest_q & rightShiftStage0Idx1Rng8_uid107_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_0(MUX,202)@0
    rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_0_s <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select_b;
    rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_0_combproc: PROCESS (rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_0_s, en, rightPaddedIn_uid18_fpAccTest_q, rightShiftStage0Idx1_uid109_alignmentShifter_uid17_fpAccTest_q, rightShiftStage0Idx2_uid112_alignmentShifter_uid17_fpAccTest_q, rightShiftStage0Idx3_uid115_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_0_s) IS
            WHEN "00" => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_0_q <= rightPaddedIn_uid18_fpAccTest_q;
            WHEN "01" => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_0_q <= rightShiftStage0Idx1_uid109_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_0_q <= rightShiftStage0Idx2_uid112_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_0_q <= rightShiftStage0Idx3_uid115_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_0_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- expX_uid6_fpAccTest(BITSELECT,5)@0
    expX_uid6_fpAccTest_b <= x(30 downto 23);

    -- rShiftConstant_uid15_fpAccTest(CONSTANT,14)
    rShiftConstant_uid15_fpAccTest_q <= "010001011";

    -- rightShiftValue_uid16_fpAccTest(SUB,15)@0
    rightShiftValue_uid16_fpAccTest_a <= STD_LOGIC_VECTOR("0" & rShiftConstant_uid15_fpAccTest_q);
    rightShiftValue_uid16_fpAccTest_b <= STD_LOGIC_VECTOR("00" & expX_uid6_fpAccTest_b);
    rightShiftValue_uid16_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(rightShiftValue_uid16_fpAccTest_a) - UNSIGNED(rightShiftValue_uid16_fpAccTest_b));
    rightShiftValue_uid16_fpAccTest_q <= rightShiftValue_uid16_fpAccTest_o(9 downto 0);

    -- rightShiftStageSel5Dto3_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select(BITSELECT,220)@0
    rightShiftStageSel5Dto3_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_in <= rightShiftValue_uid16_fpAccTest_q(5 downto 0);
    rightShiftStageSel5Dto3_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_b <= rightShiftStageSel5Dto3_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(5 downto 3);
    rightShiftStageSel5Dto3_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_c <= rightShiftStageSel5Dto3_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(2 downto 0);

    -- rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select(BITSELECT,227)@0
    rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select_b <= rightShiftStageSel5Dto3_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_b(1 downto 0);
    rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select_c <= rightShiftStageSel5Dto3_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_b(2 downto 2);

    -- rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal(MUX,204)@0
    rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_s <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select_c;
    rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_combproc: PROCESS (rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_s, en, rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_0_q, rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_1_q)
    BEGIN
        CASE (rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_s) IS
            WHEN "0" => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_q <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_0_q;
            WHEN "1" => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_q <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_msplit_1_q;
            WHEN OTHERS => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage1Idx7Rng7_uid148_alignmentShifter_uid17_fpAccTest(BITSELECT,147)@0
    rightShiftStage1Idx7Rng7_uid148_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_q(61 downto 7);

    -- rightShiftStage1Idx7_uid150_alignmentShifter_uid17_fpAccTest(BITJOIN,149)@0
    rightShiftStage1Idx7_uid150_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx7Pad7_uid149_alignmentShifter_uid17_fpAccTest_q & rightShiftStage1Idx7Rng7_uid148_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage1Idx6Pad6_uid146_alignmentShifter_uid17_fpAccTest(CONSTANT,145)
    rightShiftStage1Idx6Pad6_uid146_alignmentShifter_uid17_fpAccTest_q <= "000000";

    -- rightShiftStage1Idx6Rng6_uid145_alignmentShifter_uid17_fpAccTest(BITSELECT,144)@0
    rightShiftStage1Idx6Rng6_uid145_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_q(61 downto 6);

    -- rightShiftStage1Idx6_uid147_alignmentShifter_uid17_fpAccTest(BITJOIN,146)@0
    rightShiftStage1Idx6_uid147_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx6Pad6_uid146_alignmentShifter_uid17_fpAccTest_q & rightShiftStage1Idx6Rng6_uid145_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage1Idx5Pad5_uid143_alignmentShifter_uid17_fpAccTest(CONSTANT,142)
    rightShiftStage1Idx5Pad5_uid143_alignmentShifter_uid17_fpAccTest_q <= "00000";

    -- rightShiftStage1Idx5Rng5_uid142_alignmentShifter_uid17_fpAccTest(BITSELECT,141)@0
    rightShiftStage1Idx5Rng5_uid142_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_q(61 downto 5);

    -- rightShiftStage1Idx5_uid144_alignmentShifter_uid17_fpAccTest(BITJOIN,143)@0
    rightShiftStage1Idx5_uid144_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx5Pad5_uid143_alignmentShifter_uid17_fpAccTest_q & rightShiftStage1Idx5Rng5_uid142_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid86_zeroCounter_uid37_fpAccTest(CONSTANT,85)
    zs_uid86_zeroCounter_uid37_fpAccTest_q <= "0000";

    -- rightShiftStage1Idx4Rng4_uid139_alignmentShifter_uid17_fpAccTest(BITSELECT,138)@0
    rightShiftStage1Idx4Rng4_uid139_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_q(61 downto 4);

    -- rightShiftStage1Idx4_uid141_alignmentShifter_uid17_fpAccTest(BITJOIN,140)@0
    rightShiftStage1Idx4_uid141_alignmentShifter_uid17_fpAccTest_q <= zs_uid86_zeroCounter_uid37_fpAccTest_q & rightShiftStage1Idx4Rng4_uid139_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_1(MUX,208)@0
    rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_1_s <= rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select_b;
    rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_1_combproc: PROCESS (rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_1_s, en, rightShiftStage1Idx4_uid141_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx5_uid144_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx6_uid147_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx7_uid150_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_1_s) IS
            WHEN "00" => rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_1_q <= rightShiftStage1Idx4_uid141_alignmentShifter_uid17_fpAccTest_q;
            WHEN "01" => rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_1_q <= rightShiftStage1Idx5_uid144_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_1_q <= rightShiftStage1Idx6_uid147_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_1_q <= rightShiftStage1Idx7_uid150_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_1_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage1Idx3Pad3_uid137_alignmentShifter_uid17_fpAccTest(CONSTANT,136)
    rightShiftStage1Idx3Pad3_uid137_alignmentShifter_uid17_fpAccTest_q <= "000";

    -- rightShiftStage1Idx3Rng3_uid136_alignmentShifter_uid17_fpAccTest(BITSELECT,135)@0
    rightShiftStage1Idx3Rng3_uid136_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_q(61 downto 3);

    -- rightShiftStage1Idx3_uid138_alignmentShifter_uid17_fpAccTest(BITJOIN,137)@0
    rightShiftStage1Idx3_uid138_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx3Pad3_uid137_alignmentShifter_uid17_fpAccTest_q & rightShiftStage1Idx3Rng3_uid136_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid92_zeroCounter_uid37_fpAccTest(CONSTANT,91)
    zs_uid92_zeroCounter_uid37_fpAccTest_q <= "00";

    -- rightShiftStage1Idx2Rng2_uid133_alignmentShifter_uid17_fpAccTest(BITSELECT,132)@0
    rightShiftStage1Idx2Rng2_uid133_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_q(61 downto 2);

    -- rightShiftStage1Idx2_uid135_alignmentShifter_uid17_fpAccTest(BITJOIN,134)@0
    rightShiftStage1Idx2_uid135_alignmentShifter_uid17_fpAccTest_q <= zs_uid92_zeroCounter_uid37_fpAccTest_q & rightShiftStage1Idx2Rng2_uid133_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage1Idx1Rng1_uid130_alignmentShifter_uid17_fpAccTest(BITSELECT,129)@0
    rightShiftStage1Idx1Rng1_uid130_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_q(61 downto 1);

    -- rightShiftStage1Idx1_uid132_alignmentShifter_uid17_fpAccTest(BITJOIN,131)@0
    rightShiftStage1Idx1_uid132_alignmentShifter_uid17_fpAccTest_q <= GND_q & rightShiftStage1Idx1Rng1_uid130_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_0(MUX,207)@0
    rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_0_s <= rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select_b;
    rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_0_combproc: PROCESS (rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_0_s, en, rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_q, rightShiftStage1Idx1_uid132_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx2_uid135_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx3_uid138_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_0_s) IS
            WHEN "00" => rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_0_q <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_mfinal_q;
            WHEN "01" => rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_0_q <= rightShiftStage1Idx1_uid132_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_0_q <= rightShiftStage1Idx2_uid135_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_0_q <= rightShiftStage1Idx3_uid138_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_0_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select(BITSELECT,228)@0
    rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select_b <= rightShiftStageSel5Dto3_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_c(1 downto 0);
    rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select_c <= rightShiftStageSel5Dto3_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_c(2 downto 2);

    -- rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_mfinal(MUX,209)@0
    rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_mfinal_s <= rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_selLSBs_merged_bit_select_c;
    rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_mfinal_combproc: PROCESS (rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_mfinal_s, en, rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_0_q, rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_1_q)
    BEGIN
        CASE (rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_mfinal_s) IS
            WHEN "0" => rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_mfinal_q <= rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_0_q;
            WHEN "1" => rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_mfinal_q <= rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_msplit_1_q;
            WHEN OTHERS => rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_mfinal_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- wIntCst_uid105_alignmentShifter_uid17_fpAccTest(CONSTANT,104)
    wIntCst_uid105_alignmentShifter_uid17_fpAccTest_q <= "111110";

    -- shiftedOut_uid106_alignmentShifter_uid17_fpAccTest(COMPARE,105)@0
    shiftedOut_uid106_alignmentShifter_uid17_fpAccTest_a <= STD_LOGIC_VECTOR("00" & rightShiftValue_uid16_fpAccTest_q);
    shiftedOut_uid106_alignmentShifter_uid17_fpAccTest_b <= STD_LOGIC_VECTOR("000000" & wIntCst_uid105_alignmentShifter_uid17_fpAccTest_q);
    shiftedOut_uid106_alignmentShifter_uid17_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid106_alignmentShifter_uid17_fpAccTest_a) - UNSIGNED(shiftedOut_uid106_alignmentShifter_uid17_fpAccTest_b));
    shiftedOut_uid106_alignmentShifter_uid17_fpAccTest_n(0) <= not (shiftedOut_uid106_alignmentShifter_uid17_fpAccTest_o(11));

    -- r_uid154_alignmentShifter_uid17_fpAccTest(MUX,153)@0
    r_uid154_alignmentShifter_uid17_fpAccTest_s <= shiftedOut_uid106_alignmentShifter_uid17_fpAccTest_n;
    r_uid154_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (r_uid154_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_mfinal_q, zeroOutCst_uid153_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (r_uid154_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "0" => r_uid154_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1_uid152_alignmentShifter_uid17_fpAccTest_mfinal_q;
            WHEN "1" => r_uid154_alignmentShifter_uid17_fpAccTest_q <= zeroOutCst_uid153_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => r_uid154_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- shiftedFracUpper_uid20_fpAccTest(BITSELECT,19)@0
    shiftedFracUpper_uid20_fpAccTest_b <= r_uid154_alignmentShifter_uid17_fpAccTest_q(61 downto 24);

    -- redist9_shiftedFracUpper_uid20_fpAccTest_b_1(DELAY,240)
    redist9_shiftedFracUpper_uid20_fpAccTest_b_1 : dspba_delay
    GENERIC MAP ( width => 38, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => shiftedFracUpper_uid20_fpAccTest_b, xout => redist9_shiftedFracUpper_uid20_fpAccTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- extendedAlignedShiftedFrac_uid21_fpAccTest(BITJOIN,20)@1
    extendedAlignedShiftedFrac_uid21_fpAccTest_q <= GND_q & redist9_shiftedFracUpper_uid20_fpAccTest_b_1_q;

    -- onesComplementExtendedFrac_uid22_fpAccTest(LOGICAL,21)@1
    onesComplementExtendedFrac_uid22_fpAccTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 1 => redist11_signX_uid8_fpAccTest_b_1_q(0)) & redist11_signX_uid8_fpAccTest_b_1_q));
    onesComplementExtendedFrac_uid22_fpAccTest_q <= extendedAlignedShiftedFrac_uid21_fpAccTest_q xor onesComplementExtendedFrac_uid22_fpAccTest_b;

    -- accumulator_uid24_fpAccTest(ADD,23)@1 + 1
    accumulator_uid24_fpAccTest_cin <= redist11_signX_uid8_fpAccTest_b_1_q;
    accumulator_uid24_fpAccTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((49 downto 48 => sum_uid27_fpAccTest_b(47)) & sum_uid27_fpAccTest_b) & '1');
    accumulator_uid24_fpAccTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((49 downto 39 => onesComplementExtendedFrac_uid22_fpAccTest_q(38)) & onesComplementExtendedFrac_uid22_fpAccTest_q) & accumulator_uid24_fpAccTest_cin(0));
    accumulator_uid24_fpAccTest_i <= accumulator_uid24_fpAccTest_b;
    accumulator_uid24_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            accumulator_uid24_fpAccTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                IF (redist12_xIn_n_1_q = "1") THEN
                    accumulator_uid24_fpAccTest_o <= accumulator_uid24_fpAccTest_i;
                ELSE
                    accumulator_uid24_fpAccTest_o <= STD_LOGIC_VECTOR(SIGNED(accumulator_uid24_fpAccTest_a) + SIGNED(accumulator_uid24_fpAccTest_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    accumulator_uid24_fpAccTest_c(0) <= accumulator_uid24_fpAccTest_o(50);
    accumulator_uid24_fpAccTest_q <= accumulator_uid24_fpAccTest_o(49 downto 1);

    -- os_uid25_fpAccTest(BITJOIN,24)@2
    os_uid25_fpAccTest_q <= accumulator_uid24_fpAccTest_c & accumulator_uid24_fpAccTest_q;

    -- osr_uid26_fpAccTest(BITSELECT,25)@2
    osr_uid26_fpAccTest_in <= STD_LOGIC_VECTOR(os_uid25_fpAccTest_q(48 downto 0));
    osr_uid26_fpAccTest_b <= STD_LOGIC_VECTOR(osr_uid26_fpAccTest_in(48 downto 0));

    -- sum_uid27_fpAccTest(BITSELECT,26)@2
    sum_uid27_fpAccTest_in <= STD_LOGIC_VECTOR(osr_uid26_fpAccTest_b(47 downto 0));
    sum_uid27_fpAccTest_b <= STD_LOGIC_VECTOR(sum_uid27_fpAccTest_in(47 downto 0));

    -- accumulatorSign_uid29_fpAccTest(BITSELECT,28)@2
    accumulatorSign_uid29_fpAccTest_in <= sum_uid27_fpAccTest_b(46 downto 0);
    accumulatorSign_uid29_fpAccTest_b <= accumulatorSign_uid29_fpAccTest_in(46 downto 46);

    -- accOverflowBitMSB_uid30_fpAccTest(BITSELECT,29)@2
    accOverflowBitMSB_uid30_fpAccTest_b <= sum_uid27_fpAccTest_b(47 downto 47);

    -- accOverflow_uid32_fpAccTest(LOGICAL,31)@2
    accOverflow_uid32_fpAccTest_q <= accOverflowBitMSB_uid30_fpAccTest_b xor accumulatorSign_uid29_fpAccTest_b;

    -- redist13_xIn_n_2(DELAY,244)
    redist13_xIn_n_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist12_xIn_n_1_q, xout => redist13_xIn_n_2_q, ena => en(0), clk => clk, aclr => areset );

    -- muxAccOverflowFeedbackSignal_uid61_fpAccTest(MUX,60)@2
    muxAccOverflowFeedbackSignal_uid61_fpAccTest_s <= redist13_xIn_n_2_q;
    muxAccOverflowFeedbackSignal_uid61_fpAccTest_combproc: PROCESS (muxAccOverflowFeedbackSignal_uid61_fpAccTest_s, en, oRAccOverflowFlagFeedback_uid62_fpAccTest_q, GND_q)
    BEGIN
        CASE (muxAccOverflowFeedbackSignal_uid61_fpAccTest_s) IS
            WHEN "0" => muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= oRAccOverflowFlagFeedback_uid62_fpAccTest_q;
            WHEN "1" => muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= GND_q;
            WHEN OTHERS => muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oRAccOverflowFlagFeedback_uid62_fpAccTest(LOGICAL,61)@2 + 1
    oRAccOverflowFlagFeedback_uid62_fpAccTest_qi <= muxAccOverflowFeedbackSignal_uid61_fpAccTest_q or accOverflow_uid32_fpAccTest_q;
    oRAccOverflowFlagFeedback_uid62_fpAccTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRAccOverflowFlagFeedback_uid62_fpAccTest_qi, xout => oRAccOverflowFlagFeedback_uid62_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- delayedAccOverflowFeedbackSignal_uid60_fpAccTest(DELAY,59)
    delayedAccOverflowFeedbackSignal_uid60_fpAccTest : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRAccOverflowFlagFeedback_uid62_fpAccTest_q, xout => delayedAccOverflowFeedbackSignal_uid60_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- expNotZero_uid56_fpAccTest(LOGICAL,55)@0
    expNotZero_uid56_fpAccTest_q <= "1" WHEN expX_uid6_fpAccTest_b /= "00000000" ELSE "0";

    -- expLTLSBA_uid11_fpAccTest(CONSTANT,10)
    expLTLSBA_uid11_fpAccTest_q <= "01100101";

    -- cmpLT_expX_expLTLSBA_uid12_fpAccTest(COMPARE,11)@0
    cmpLT_expX_expLTLSBA_uid12_fpAccTest_a <= STD_LOGIC_VECTOR("00" & expX_uid6_fpAccTest_b);
    cmpLT_expX_expLTLSBA_uid12_fpAccTest_b <= STD_LOGIC_VECTOR("00" & expLTLSBA_uid11_fpAccTest_q);
    cmpLT_expX_expLTLSBA_uid12_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(cmpLT_expX_expLTLSBA_uid12_fpAccTest_a) - UNSIGNED(cmpLT_expX_expLTLSBA_uid12_fpAccTest_b));
    cmpLT_expX_expLTLSBA_uid12_fpAccTest_c(0) <= cmpLT_expX_expLTLSBA_uid12_fpAccTest_o(9);

    -- underflowCond_uid57_fpAccTest(LOGICAL,56)@0 + 1
    underflowCond_uid57_fpAccTest_qi <= cmpLT_expX_expLTLSBA_uid12_fpAccTest_c and expNotZero_uid56_fpAccTest_q;
    underflowCond_uid57_fpAccTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => underflowCond_uid57_fpAccTest_qi, xout => underflowCond_uid57_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist5_underflowCond_uid57_fpAccTest_q_2(DELAY,236)
    redist5_underflowCond_uid57_fpAccTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => underflowCond_uid57_fpAccTest_q, xout => redist5_underflowCond_uid57_fpAccTest_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- muxXUnderflowFeedbackSignal_uid55_fpAccTest(MUX,54)@2
    muxXUnderflowFeedbackSignal_uid55_fpAccTest_s <= redist13_xIn_n_2_q;
    muxXUnderflowFeedbackSignal_uid55_fpAccTest_combproc: PROCESS (muxXUnderflowFeedbackSignal_uid55_fpAccTest_s, en, oRXUnderflowFlagFeedback_uid58_fpAccTest_q, GND_q)
    BEGIN
        CASE (muxXUnderflowFeedbackSignal_uid55_fpAccTest_s) IS
            WHEN "0" => muxXUnderflowFeedbackSignal_uid55_fpAccTest_q <= oRXUnderflowFlagFeedback_uid58_fpAccTest_q;
            WHEN "1" => muxXUnderflowFeedbackSignal_uid55_fpAccTest_q <= GND_q;
            WHEN OTHERS => muxXUnderflowFeedbackSignal_uid55_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oRXUnderflowFlagFeedback_uid58_fpAccTest(LOGICAL,57)@2 + 1
    oRXUnderflowFlagFeedback_uid58_fpAccTest_qi <= muxXUnderflowFeedbackSignal_uid55_fpAccTest_q or redist5_underflowCond_uid57_fpAccTest_q_2_q;
    oRXUnderflowFlagFeedback_uid58_fpAccTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXUnderflowFlagFeedback_uid58_fpAccTest_qi, xout => oRXUnderflowFlagFeedback_uid58_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- delayedXUnderflowFeedbackSignal_uid54_fpAccTest(DELAY,53)
    delayedXUnderflowFeedbackSignal_uid54_fpAccTest : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXUnderflowFlagFeedback_uid58_fpAccTest_q, xout => delayedXUnderflowFeedbackSignal_uid54_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- expGTMaxMSBX_uid13_fpAccTest(CONSTANT,12)
    expGTMaxMSBX_uid13_fpAccTest_q <= "10001011";

    -- cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest(COMPARE,13)@0 + 1
    cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_a <= STD_LOGIC_VECTOR("00" & expGTMaxMSBX_uid13_fpAccTest_q);
    cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_b <= STD_LOGIC_VECTOR("00" & expX_uid6_fpAccTest_b);
    cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_a) - UNSIGNED(cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_b));
            END IF;
        END IF;
    END PROCESS;
    cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c(0) <= cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_o(9);

    -- redist10_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_2(DELAY,241)
    redist10_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c, xout => redist10_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_2_q, ena => en(0), clk => clk, aclr => areset );

    -- muxXOverflowFeedbackSignal_uid51_fpAccTest(MUX,50)@2
    muxXOverflowFeedbackSignal_uid51_fpAccTest_s <= redist13_xIn_n_2_q;
    muxXOverflowFeedbackSignal_uid51_fpAccTest_combproc: PROCESS (muxXOverflowFeedbackSignal_uid51_fpAccTest_s, en, oRXOverflowFlagFeedback_uid52_fpAccTest_q, GND_q)
    BEGIN
        CASE (muxXOverflowFeedbackSignal_uid51_fpAccTest_s) IS
            WHEN "0" => muxXOverflowFeedbackSignal_uid51_fpAccTest_q <= oRXOverflowFlagFeedback_uid52_fpAccTest_q;
            WHEN "1" => muxXOverflowFeedbackSignal_uid51_fpAccTest_q <= GND_q;
            WHEN OTHERS => muxXOverflowFeedbackSignal_uid51_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oRXOverflowFlagFeedback_uid52_fpAccTest(LOGICAL,51)@2 + 1
    oRXOverflowFlagFeedback_uid52_fpAccTest_qi <= muxXOverflowFeedbackSignal_uid51_fpAccTest_q or redist10_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_2_q;
    oRXOverflowFlagFeedback_uid52_fpAccTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXOverflowFlagFeedback_uid52_fpAccTest_qi, xout => oRXOverflowFlagFeedback_uid52_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- delayedXOverflowFeedbackSignal_uid50_fpAccTest(DELAY,49)
    delayedXOverflowFeedbackSignal_uid50_fpAccTest : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXOverflowFlagFeedback_uid52_fpAccTest_q, xout => delayedXOverflowFeedbackSignal_uid50_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist8_accumulatorSign_uid29_fpAccTest_b_2(DELAY,239)
    redist8_accumulatorSign_uid29_fpAccTest_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => accumulatorSign_uid29_fpAccTest_b, xout => redist8_accumulatorSign_uid29_fpAccTest_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- accValidRange_uid33_fpAccTest(BITSELECT,32)@2
    accValidRange_uid33_fpAccTest_in <= sum_uid27_fpAccTest_b(46 downto 0);
    accValidRange_uid33_fpAccTest_b <= accValidRange_uid33_fpAccTest_in(46 downto 0);

    -- accOnesComplement_uid34_fpAccTest(LOGICAL,33)@2
    accOnesComplement_uid34_fpAccTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((46 downto 1 => accumulatorSign_uid29_fpAccTest_b(0)) & accumulatorSign_uid29_fpAccTest_b));
    accOnesComplement_uid34_fpAccTest_q <= accValidRange_uid33_fpAccTest_b xor accOnesComplement_uid34_fpAccTest_b;

    -- accValuePositive_uid35_fpAccTest(ADD,34)@2 + 1
    accValuePositive_uid35_fpAccTest_a <= STD_LOGIC_VECTOR("0" & accOnesComplement_uid34_fpAccTest_q);
    accValuePositive_uid35_fpAccTest_b <= STD_LOGIC_VECTOR("00000000000000000000000000000000000000000000000" & accumulatorSign_uid29_fpAccTest_b);
    accValuePositive_uid35_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            accValuePositive_uid35_fpAccTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                accValuePositive_uid35_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(accValuePositive_uid35_fpAccTest_a) + UNSIGNED(accValuePositive_uid35_fpAccTest_b));
            END IF;
        END IF;
    END PROCESS;
    accValuePositive_uid35_fpAccTest_q <= accValuePositive_uid35_fpAccTest_o(47 downto 0);

    -- posAccWoLeadingZeroBit_uid36_fpAccTest(BITSELECT,35)@3
    posAccWoLeadingZeroBit_uid36_fpAccTest_in <= accValuePositive_uid35_fpAccTest_q(45 downto 0);
    posAccWoLeadingZeroBit_uid36_fpAccTest_b <= posAccWoLeadingZeroBit_uid36_fpAccTest_in(45 downto 0);

    -- rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,221)@3
    rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= posAccWoLeadingZeroBit_uid36_fpAccTest_b(45 downto 14);
    rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= posAccWoLeadingZeroBit_uid36_fpAccTest_b(13 downto 0);

    -- vCount_uid68_zeroCounter_uid37_fpAccTest(LOGICAL,67)@3
    vCount_uid68_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid66_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist2_vCount_uid68_zeroCounter_uid37_fpAccTest_q_1(DELAY,233)
    redist2_vCount_uid68_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid68_zeroCounter_uid37_fpAccTest_q, xout => redist2_vCount_uid68_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- mO_uid69_zeroCounter_uid37_fpAccTest(CONSTANT,68)
    mO_uid69_zeroCounter_uid37_fpAccTest_q <= "111111111111111111";

    -- cStage_uid71_zeroCounter_uid37_fpAccTest(BITJOIN,70)@3
    cStage_uid71_zeroCounter_uid37_fpAccTest_q <= rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_c & mO_uid69_zeroCounter_uid37_fpAccTest_q;

    -- vStagei_uid73_zeroCounter_uid37_fpAccTest(MUX,72)@3
    vStagei_uid73_zeroCounter_uid37_fpAccTest_s <= vCount_uid68_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid73_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid73_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b, cStage_uid71_zeroCounter_uid37_fpAccTest_q)
    BEGIN
        CASE (vStagei_uid73_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid73_zeroCounter_uid37_fpAccTest_q <= rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid73_zeroCounter_uid37_fpAccTest_q <= cStage_uid71_zeroCounter_uid37_fpAccTest_q;
            WHEN OTHERS => vStagei_uid73_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,222)@3
    rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid73_zeroCounter_uid37_fpAccTest_q(31 downto 16);
    rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid73_zeroCounter_uid37_fpAccTest_q(15 downto 0);

    -- vCount_uid76_zeroCounter_uid37_fpAccTest(LOGICAL,75)@3
    vCount_uid76_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid74_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist1_vCount_uid76_zeroCounter_uid37_fpAccTest_q_1(DELAY,232)
    redist1_vCount_uid76_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid76_zeroCounter_uid37_fpAccTest_q, xout => redist1_vCount_uid76_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid79_zeroCounter_uid37_fpAccTest(MUX,78)@3
    vStagei_uid79_zeroCounter_uid37_fpAccTest_s <= vCount_uid76_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid79_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid79_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid79_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,223)@3
    rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid79_zeroCounter_uid37_fpAccTest_q(15 downto 8);
    rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid79_zeroCounter_uid37_fpAccTest_q(7 downto 0);

    -- vCount_uid82_zeroCounter_uid37_fpAccTest(LOGICAL,81)@3
    vCount_uid82_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zeroExponent_uid42_fpAccTest_q ELSE "0";

    -- redist0_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1(DELAY,231)
    redist0_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid82_zeroCounter_uid37_fpAccTest_q, xout => redist0_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid85_zeroCounter_uid37_fpAccTest(MUX,84)@3 + 1
    vStagei_uid85_zeroCounter_uid37_fpAccTest_s <= vCount_uid82_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid85_zeroCounter_uid37_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (vStagei_uid85_zeroCounter_uid37_fpAccTest_s) IS
                    WHEN "0" => vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
                    WHEN "1" => vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
                    WHEN OTHERS => vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,224)@4
    rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid85_zeroCounter_uid37_fpAccTest_q(7 downto 4);
    rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid85_zeroCounter_uid37_fpAccTest_q(3 downto 0);

    -- vCount_uid88_zeroCounter_uid37_fpAccTest(LOGICAL,87)@4
    vCount_uid88_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid86_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- vStagei_uid91_zeroCounter_uid37_fpAccTest(MUX,90)@4
    vStagei_uid91_zeroCounter_uid37_fpAccTest_s <= vCount_uid88_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid91_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid91_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid91_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,225)@4
    rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid91_zeroCounter_uid37_fpAccTest_q(3 downto 2);
    rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid91_zeroCounter_uid37_fpAccTest_q(1 downto 0);

    -- vCount_uid94_zeroCounter_uid37_fpAccTest(LOGICAL,93)@4
    vCount_uid94_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid92_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- vStagei_uid97_zeroCounter_uid37_fpAccTest(MUX,96)@4
    vStagei_uid97_zeroCounter_uid37_fpAccTest_s <= vCount_uid94_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid97_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid97_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid97_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid97_zeroCounter_uid37_fpAccTest_q <= rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid97_zeroCounter_uid37_fpAccTest_q <= rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid97_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid99_zeroCounter_uid37_fpAccTest(BITSELECT,98)@4
    rVStage_uid99_zeroCounter_uid37_fpAccTest_b <= vStagei_uid97_zeroCounter_uid37_fpAccTest_q(1 downto 1);

    -- vCount_uid100_zeroCounter_uid37_fpAccTest(LOGICAL,99)@4
    vCount_uid100_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid99_zeroCounter_uid37_fpAccTest_b = GND_q ELSE "0";

    -- r_uid101_zeroCounter_uid37_fpAccTest(BITJOIN,100)@4
    r_uid101_zeroCounter_uid37_fpAccTest_q <= redist2_vCount_uid68_zeroCounter_uid37_fpAccTest_q_1_q & redist1_vCount_uid76_zeroCounter_uid37_fpAccTest_q_1_q & redist0_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1_q & vCount_uid88_zeroCounter_uid37_fpAccTest_q & vCount_uid94_zeroCounter_uid37_fpAccTest_q & vCount_uid100_zeroCounter_uid37_fpAccTest_q;

    -- expRBias_uid41_fpAccTest(CONSTANT,40)
    expRBias_uid41_fpAccTest_q <= "010010011";

    -- resExpSub_uid43_fpAccTest(SUB,42)@4
    resExpSub_uid43_fpAccTest_a <= STD_LOGIC_VECTOR("0" & expRBias_uid41_fpAccTest_q);
    resExpSub_uid43_fpAccTest_b <= STD_LOGIC_VECTOR("0000" & r_uid101_zeroCounter_uid37_fpAccTest_q);
    resExpSub_uid43_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(resExpSub_uid43_fpAccTest_a) - UNSIGNED(resExpSub_uid43_fpAccTest_b));
    resExpSub_uid43_fpAccTest_q <= resExpSub_uid43_fpAccTest_o(9 downto 0);

    -- finalExponent_uid44_fpAccTest(BITSELECT,43)@4
    finalExponent_uid44_fpAccTest_in <= resExpSub_uid43_fpAccTest_q(7 downto 0);
    finalExponent_uid44_fpAccTest_b <= finalExponent_uid44_fpAccTest_in(7 downto 0);

    -- ShiftedOutComparator_uid38_fpAccTest(CONSTANT,37)
    ShiftedOutComparator_uid38_fpAccTest_q <= "101110";

    -- accResOutOfExpRange_uid39_fpAccTest(LOGICAL,38)@4
    accResOutOfExpRange_uid39_fpAccTest_q <= "1" WHEN ShiftedOutComparator_uid38_fpAccTest_q = r_uid101_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- finalExpUpdated_uid45_fpAccTest(MUX,44)@4
    finalExpUpdated_uid45_fpAccTest_s <= accResOutOfExpRange_uid39_fpAccTest_q;
    finalExpUpdated_uid45_fpAccTest_combproc: PROCESS (finalExpUpdated_uid45_fpAccTest_s, en, finalExponent_uid44_fpAccTest_b, zeroExponent_uid42_fpAccTest_q)
    BEGIN
        CASE (finalExpUpdated_uid45_fpAccTest_s) IS
            WHEN "0" => finalExpUpdated_uid45_fpAccTest_q <= finalExponent_uid44_fpAccTest_b;
            WHEN "1" => finalExpUpdated_uid45_fpAccTest_q <= zeroExponent_uid42_fpAccTest_q;
            WHEN OTHERS => finalExpUpdated_uid45_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist7_accValuePositive_uid35_fpAccTest_q_2(DELAY,238)
    redist7_accValuePositive_uid35_fpAccTest_q_2 : dspba_delay
    GENERIC MAP ( width => 48, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => accValuePositive_uid35_fpAccTest_q, xout => redist7_accValuePositive_uid35_fpAccTest_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- leftShiftStage0Idx5Rng40_uid171_normalizationShifter_uid40_fpAccTest(BITSELECT,170)@4
    leftShiftStage0Idx5Rng40_uid171_normalizationShifter_uid40_fpAccTest_in <= redist7_accValuePositive_uid35_fpAccTest_q_2_q(7 downto 0);
    leftShiftStage0Idx5Rng40_uid171_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage0Idx5Rng40_uid171_normalizationShifter_uid40_fpAccTest_in(7 downto 0);

    -- leftShiftStage0Idx5_uid172_normalizationShifter_uid40_fpAccTest(BITJOIN,171)@4
    leftShiftStage0Idx5_uid172_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx5Rng40_uid171_normalizationShifter_uid40_fpAccTest_b & rightShiftStage0Idx5Pad40_uid120_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage0Idx4Rng32_uid168_normalizationShifter_uid40_fpAccTest(BITSELECT,167)@4
    leftShiftStage0Idx4Rng32_uid168_normalizationShifter_uid40_fpAccTest_in <= redist7_accValuePositive_uid35_fpAccTest_q_2_q(15 downto 0);
    leftShiftStage0Idx4Rng32_uid168_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage0Idx4Rng32_uid168_normalizationShifter_uid40_fpAccTest_in(15 downto 0);

    -- leftShiftStage0Idx4_uid169_normalizationShifter_uid40_fpAccTest(BITJOIN,168)@4
    leftShiftStage0Idx4_uid169_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx4Rng32_uid168_normalizationShifter_uid40_fpAccTest_b & zs_uid66_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_1(MUX,213)@4
    leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_1_s <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select_b;
    leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_1_combproc: PROCESS (leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_1_s, en, leftShiftStage0Idx4_uid169_normalizationShifter_uid40_fpAccTest_q, leftShiftStage0Idx5_uid172_normalizationShifter_uid40_fpAccTest_q, rightShiftStage0Idx6Pad48_uid123_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_1_s) IS
            WHEN "00" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_1_q <= leftShiftStage0Idx4_uid169_normalizationShifter_uid40_fpAccTest_q;
            WHEN "01" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_1_q <= leftShiftStage0Idx5_uid172_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_1_q <= rightShiftStage0Idx6Pad48_uid123_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_1_q <= rightShiftStage0Idx6Pad48_uid123_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_1_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage0Idx3Rng24_uid165_normalizationShifter_uid40_fpAccTest(BITSELECT,164)@4
    leftShiftStage0Idx3Rng24_uid165_normalizationShifter_uid40_fpAccTest_in <= redist7_accValuePositive_uid35_fpAccTest_q_2_q(23 downto 0);
    leftShiftStage0Idx3Rng24_uid165_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage0Idx3Rng24_uid165_normalizationShifter_uid40_fpAccTest_in(23 downto 0);

    -- leftShiftStage0Idx3_uid166_normalizationShifter_uid40_fpAccTest(BITJOIN,165)@4
    leftShiftStage0Idx3_uid166_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx3Rng24_uid165_normalizationShifter_uid40_fpAccTest_b & rightShiftStage0Idx3Pad24_uid114_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage0Idx2Rng16_uid162_normalizationShifter_uid40_fpAccTest(BITSELECT,161)@4
    leftShiftStage0Idx2Rng16_uid162_normalizationShifter_uid40_fpAccTest_in <= redist7_accValuePositive_uid35_fpAccTest_q_2_q(31 downto 0);
    leftShiftStage0Idx2Rng16_uid162_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage0Idx2Rng16_uid162_normalizationShifter_uid40_fpAccTest_in(31 downto 0);

    -- leftShiftStage0Idx2_uid163_normalizationShifter_uid40_fpAccTest(BITJOIN,162)@4
    leftShiftStage0Idx2_uid163_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx2Rng16_uid162_normalizationShifter_uid40_fpAccTest_b & zs_uid74_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage0Idx1Rng8_uid159_normalizationShifter_uid40_fpAccTest(BITSELECT,158)@4
    leftShiftStage0Idx1Rng8_uid159_normalizationShifter_uid40_fpAccTest_in <= redist7_accValuePositive_uid35_fpAccTest_q_2_q(39 downto 0);
    leftShiftStage0Idx1Rng8_uid159_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage0Idx1Rng8_uid159_normalizationShifter_uid40_fpAccTest_in(39 downto 0);

    -- leftShiftStage0Idx1_uid160_normalizationShifter_uid40_fpAccTest(BITJOIN,159)@4
    leftShiftStage0Idx1_uid160_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx1Rng8_uid159_normalizationShifter_uid40_fpAccTest_b & zeroExponent_uid42_fpAccTest_q;

    -- leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_0(MUX,212)@4
    leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_0_s <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select_b;
    leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_0_combproc: PROCESS (leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_0_s, en, redist7_accValuePositive_uid35_fpAccTest_q_2_q, leftShiftStage0Idx1_uid160_normalizationShifter_uid40_fpAccTest_q, leftShiftStage0Idx2_uid163_normalizationShifter_uid40_fpAccTest_q, leftShiftStage0Idx3_uid166_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_0_s) IS
            WHEN "00" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_0_q <= redist7_accValuePositive_uid35_fpAccTest_q_2_q;
            WHEN "01" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_0_q <= leftShiftStage0Idx1_uid160_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_0_q <= leftShiftStage0Idx2_uid163_normalizationShifter_uid40_fpAccTest_q;
            WHEN "11" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_0_q <= leftShiftStage0Idx3_uid166_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_0_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStageSel5Dto3_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select(BITSELECT,226)@4
    leftShiftStageSel5Dto3_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_b <= r_uid101_zeroCounter_uid37_fpAccTest_q(5 downto 3);
    leftShiftStageSel5Dto3_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_c <= r_uid101_zeroCounter_uid37_fpAccTest_q(2 downto 0);

    -- leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select(BITSELECT,229)@4
    leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select_b <= leftShiftStageSel5Dto3_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_b(1 downto 0);
    leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select_c <= leftShiftStageSel5Dto3_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_b(2 downto 2);

    -- leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal(MUX,214)@4
    leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_s <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select_c;
    leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_combproc: PROCESS (leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_s, en, leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_0_q, leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_1_q)
    BEGIN
        CASE (leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_s) IS
            WHEN "0" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_q <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_0_q;
            WHEN "1" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_q <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_msplit_1_q;
            WHEN OTHERS => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage1Idx7Rng7_uid196_normalizationShifter_uid40_fpAccTest(BITSELECT,195)@4
    leftShiftStage1Idx7Rng7_uid196_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_q(40 downto 0);
    leftShiftStage1Idx7Rng7_uid196_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx7Rng7_uid196_normalizationShifter_uid40_fpAccTest_in(40 downto 0);

    -- leftShiftStage1Idx7_uid197_normalizationShifter_uid40_fpAccTest(BITJOIN,196)@4
    leftShiftStage1Idx7_uid197_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx7Rng7_uid196_normalizationShifter_uid40_fpAccTest_b & rightShiftStage1Idx7Pad7_uid149_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage1Idx6Rng6_uid193_normalizationShifter_uid40_fpAccTest(BITSELECT,192)@4
    leftShiftStage1Idx6Rng6_uid193_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_q(41 downto 0);
    leftShiftStage1Idx6Rng6_uid193_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx6Rng6_uid193_normalizationShifter_uid40_fpAccTest_in(41 downto 0);

    -- leftShiftStage1Idx6_uid194_normalizationShifter_uid40_fpAccTest(BITJOIN,193)@4
    leftShiftStage1Idx6_uid194_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx6Rng6_uid193_normalizationShifter_uid40_fpAccTest_b & rightShiftStage1Idx6Pad6_uid146_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage1Idx5Rng5_uid190_normalizationShifter_uid40_fpAccTest(BITSELECT,189)@4
    leftShiftStage1Idx5Rng5_uid190_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_q(42 downto 0);
    leftShiftStage1Idx5Rng5_uid190_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx5Rng5_uid190_normalizationShifter_uid40_fpAccTest_in(42 downto 0);

    -- leftShiftStage1Idx5_uid191_normalizationShifter_uid40_fpAccTest(BITJOIN,190)@4
    leftShiftStage1Idx5_uid191_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx5Rng5_uid190_normalizationShifter_uid40_fpAccTest_b & rightShiftStage1Idx5Pad5_uid143_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage1Idx4Rng4_uid187_normalizationShifter_uid40_fpAccTest(BITSELECT,186)@4
    leftShiftStage1Idx4Rng4_uid187_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_q(43 downto 0);
    leftShiftStage1Idx4Rng4_uid187_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx4Rng4_uid187_normalizationShifter_uid40_fpAccTest_in(43 downto 0);

    -- leftShiftStage1Idx4_uid188_normalizationShifter_uid40_fpAccTest(BITJOIN,187)@4
    leftShiftStage1Idx4_uid188_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx4Rng4_uid187_normalizationShifter_uid40_fpAccTest_b & zs_uid86_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_1(MUX,218)@4
    leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_1_s <= leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select_b;
    leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_1_combproc: PROCESS (leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_1_s, en, leftShiftStage1Idx4_uid188_normalizationShifter_uid40_fpAccTest_q, leftShiftStage1Idx5_uid191_normalizationShifter_uid40_fpAccTest_q, leftShiftStage1Idx6_uid194_normalizationShifter_uid40_fpAccTest_q, leftShiftStage1Idx7_uid197_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_1_s) IS
            WHEN "00" => leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_1_q <= leftShiftStage1Idx4_uid188_normalizationShifter_uid40_fpAccTest_q;
            WHEN "01" => leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_1_q <= leftShiftStage1Idx5_uid191_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_1_q <= leftShiftStage1Idx6_uid194_normalizationShifter_uid40_fpAccTest_q;
            WHEN "11" => leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_1_q <= leftShiftStage1Idx7_uid197_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_1_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage1Idx3Rng3_uid184_normalizationShifter_uid40_fpAccTest(BITSELECT,183)@4
    leftShiftStage1Idx3Rng3_uid184_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_q(44 downto 0);
    leftShiftStage1Idx3Rng3_uid184_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx3Rng3_uid184_normalizationShifter_uid40_fpAccTest_in(44 downto 0);

    -- leftShiftStage1Idx3_uid185_normalizationShifter_uid40_fpAccTest(BITJOIN,184)@4
    leftShiftStage1Idx3_uid185_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx3Rng3_uid184_normalizationShifter_uid40_fpAccTest_b & rightShiftStage1Idx3Pad3_uid137_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage1Idx2Rng2_uid181_normalizationShifter_uid40_fpAccTest(BITSELECT,180)@4
    leftShiftStage1Idx2Rng2_uid181_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_q(45 downto 0);
    leftShiftStage1Idx2Rng2_uid181_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx2Rng2_uid181_normalizationShifter_uid40_fpAccTest_in(45 downto 0);

    -- leftShiftStage1Idx2_uid182_normalizationShifter_uid40_fpAccTest(BITJOIN,181)@4
    leftShiftStage1Idx2_uid182_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx2Rng2_uid181_normalizationShifter_uid40_fpAccTest_b & zs_uid92_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage1Idx1Rng1_uid178_normalizationShifter_uid40_fpAccTest(BITSELECT,177)@4
    leftShiftStage1Idx1Rng1_uid178_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_q(46 downto 0);
    leftShiftStage1Idx1Rng1_uid178_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx1Rng1_uid178_normalizationShifter_uid40_fpAccTest_in(46 downto 0);

    -- leftShiftStage1Idx1_uid179_normalizationShifter_uid40_fpAccTest(BITJOIN,178)@4
    leftShiftStage1Idx1_uid179_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx1Rng1_uid178_normalizationShifter_uid40_fpAccTest_b & GND_q;

    -- leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_0(MUX,217)@4
    leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_0_s <= leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select_b;
    leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_0_combproc: PROCESS (leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_0_s, en, leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_q, leftShiftStage1Idx1_uid179_normalizationShifter_uid40_fpAccTest_q, leftShiftStage1Idx2_uid182_normalizationShifter_uid40_fpAccTest_q, leftShiftStage1Idx3_uid185_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_0_s) IS
            WHEN "00" => leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_0_q <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_mfinal_q;
            WHEN "01" => leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_0_q <= leftShiftStage1Idx1_uid179_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_0_q <= leftShiftStage1Idx2_uid182_normalizationShifter_uid40_fpAccTest_q;
            WHEN "11" => leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_0_q <= leftShiftStage1Idx3_uid185_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_0_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select(BITSELECT,230)@4
    leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select_b <= leftShiftStageSel5Dto3_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_c(1 downto 0);
    leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select_c <= leftShiftStageSel5Dto3_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_c(2 downto 2);

    -- leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_mfinal(MUX,219)@4
    leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_mfinal_s <= leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_selLSBs_merged_bit_select_c;
    leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_mfinal_combproc: PROCESS (leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_mfinal_s, en, leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_0_q, leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_1_q)
    BEGIN
        CASE (leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_mfinal_s) IS
            WHEN "0" => leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_mfinal_q <= leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_0_q;
            WHEN "1" => leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_mfinal_q <= leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_msplit_1_q;
            WHEN OTHERS => leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_mfinal_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracR_uid46_fpAccTest(BITSELECT,45)@4
    fracR_uid46_fpAccTest_in <= leftShiftStage1_uid199_normalizationShifter_uid40_fpAccTest_mfinal_q(44 downto 0);
    fracR_uid46_fpAccTest_b <= fracR_uid46_fpAccTest_in(44 downto 22);

    -- R_uid47_fpAccTest(BITJOIN,46)@4
    R_uid47_fpAccTest_q <= redist8_accumulatorSign_uid29_fpAccTest_b_2_q & finalExpUpdated_uid45_fpAccTest_q & fracR_uid46_fpAccTest_b;

    -- xOut(GPOUT,4)@4
    r <= R_uid47_fpAccTest_q;
    xo <= delayedXOverflowFeedbackSignal_uid50_fpAccTest_q;
    xu <= delayedXUnderflowFeedbackSignal_uid54_fpAccTest_q;
    ao <= delayedAccOverflowFeedbackSignal_uid60_fpAccTest_q;

END normal;
