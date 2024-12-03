"!https://codingdojo.org/kata/StringCalculator/
"!https://github.com/walibens/ASEPL_Certif_Practical_part.git

"- Acceptance 1,2;3#4 gives 10
"- emtpy string give 0
"- simple number : 1 gives 1, 5 give 5
"- double number : 1,2 gives 3
"- triple number : 1,2,3 gives 6
"- different separator : and / and #

REPORT yr_pl_certif_string_calc_wbs.

CLASS lcl_string_calculator DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS add
      IMPORTING
        string        TYPE string
      RETURNING
        VALUE(result) TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_string_calculator IMPLEMENTATION.


  METHOD add.
      result = cond #( when string = '1' then 1 else 0 ).
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
      one_gives_one FOR TESTING.
ENDCLASS.

CLASS ltc_string_calculator IMPLEMENTATION.
  METHOD setup.
    cut = NEW #(  ).
  ENDMETHOD.

  METHOD acceptance_test.
    cl_abap_unit_assert=>assert_equals( exp = 10
                                        act = cut->add( '1,2;3#4' ) ).
  ENDMETHOD.
  METHOD empty_string_gives_0.
    cl_abap_unit_assert=>assert_equals( exp = 0
                                        act = cut->add( '' ) ).

  ENDMETHOD.

  METHOD one_gives_one.
    cl_abap_unit_assert=>assert_equals( exp = 1
                                        act = cut->add( '1' ) ).

  ENDMETHOD.

ENDCLASS.
