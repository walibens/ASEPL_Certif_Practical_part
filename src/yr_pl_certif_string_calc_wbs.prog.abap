"!https://codingdojo.org/kata/StringCalculator/
"!https://github.com/walibens/ASEPL_Certif_Practical_part.git

"- Acceptance 1,2;3#4 gives 10
"+ emtpy string give 0
"+ simple number : 1 gives 1, 5 give 5
"+ number with 2 digits
"+ double number : 1,2 gives 3
"+ triple number : 1,2,3 gives 6
"+ unknown numbers
"+ different separator : and / and #
"+ any specific character
"- letters separator

REPORT yr_pl_certif_string_calc_wbs.

CLASS lcl_string_calculator DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS calculate
      IMPORTING
        string        TYPE string
      RETURNING
        VALUE(result) TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_string_calculator IMPLEMENTATION.
  METHOD calculate.
    DATA lt_numbers TYPE string_table.

    DATA(input) = string.
    REPLACE ALL OCCURRENCES OF REGEX '[\/#;]' IN input WITH ','.

    SPLIT input AT ',' INTO TABLE lt_numbers.
    LOOP AT lt_numbers INTO DATA(number).
      result += number.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS ltc_string_calculator DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut TYPE REF TO lcl_string_calculator.
    METHODS:
      setup,
      acceptance_test FOR TESTING RAISING cx_static_check,
      empty_string_gives_0 FOR TESTING,
      one_gives_one FOR TESTING,
      five_gives_five FOR TESTING RAISING cx_static_check,
      number_with_2_digits FOR TESTING RAISING cx_static_check,
      one_coma_two_gives_3 FOR TESTING RAISING cx_static_check,
      one_two_three_gives_6 FOR TESTING RAISING cx_static_check,
      unknown_numbers FOR TESTING RAISING cx_static_check,
      slash_separator FOR TESTING RAISING cx_static_check,
      dash_separator FOR TESTING RAISING cx_static_check,
      any_separator FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltc_string_calculator IMPLEMENTATION.
  METHOD setup.
    cut = NEW #(  ).
  ENDMETHOD.

  METHOD acceptance_test.
    cl_abap_unit_assert=>assert_equals( exp = 10
                                        act = cut->calculate( '1,2;3#4' ) ).
  ENDMETHOD.

  METHOD empty_string_gives_0.
    cl_abap_unit_assert=>assert_equals( exp = 0
                                        act = cut->calculate( '' ) ).

  ENDMETHOD.

  METHOD one_gives_one.
    cl_abap_unit_assert=>assert_equals( exp = 1
                                        act = cut->calculate( '1' ) ).

  ENDMETHOD.

  METHOD five_gives_five.
    cl_abap_unit_assert=>assert_equals( exp = 5
                                        act = cut->calculate( '5' ) ).

  ENDMETHOD.

  METHOD number_with_2_digits.
    cl_abap_unit_assert=>assert_equals( exp = 79
                                        act = cut->calculate( '79' ) ).

  ENDMETHOD.

  METHOD one_coma_two_gives_3.
    cl_abap_unit_assert=>assert_equals( exp = 3 act = cut->calculate( '1,2' ) ).

  ENDMETHOD.

  METHOD one_two_three_gives_6.
    cl_abap_unit_assert=>assert_equals( exp = 6 act = cut->calculate( '1,2,3' ) ).

  ENDMETHOD.

  METHOD unknown_numbers.
    cl_abap_unit_assert=>assert_equals( exp = 28 act = cut->calculate( '1,2,3,4,5,6,7' ) ).

  ENDMETHOD.

  METHOD slash_separator.
    cl_abap_unit_assert=>assert_equals( exp = 10 act = cut->calculate( '1,2,3/4' ) ).
  ENDMETHOD.

  METHOD dash_separator.
    cl_abap_unit_assert=>assert_equals( exp = 10 act = cut->calculate( '1#2#3/4' ) ).
  ENDMETHOD.

  METHOD any_separator.
    cl_abap_unit_assert=>assert_equals( exp = 10 act = cut->calculate( '1##2;3//4' ) ).
  ENDMETHOD.
ENDCLASS.
