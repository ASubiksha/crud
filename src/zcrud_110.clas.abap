CLASS zcrud_110 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.



CLASS zcrud_110 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lt_students TYPE TABLE OF zdata_table_110,
          ls_student  TYPE zdata_table_110.

*-----------------------------------
* CREATE (UPSERT)
*-----------------------------------

    ls_student-id = 1.
    ls_student-name = 'Alice'.
    ls_student-marks = 30.
    APPEND ls_student TO lt_students.

    CLEAR ls_student.

    ls_student-id = 2.
    ls_student-name = 'Bob'.
    ls_student-marks = 20.
    APPEND ls_student TO lt_students.

    MODIFY zdata_table_110 FROM TABLE @lt_students.

    IF sy-subrc = 0.
      out->write( 'Step 1: Alice and Bob inserted successfully' ).
    ENDIF.


*-----------------------------------
* READ
*-----------------------------------

    SELECT SINGLE *
    FROM zdata_table_110
    WHERE id = 1
    INTO @ls_student.

    IF sy-subrc = 0.
      out->write( |Step 2: Verification → Name: { ls_student-name } Marks: { ls_student-marks }| ).
    ENDIF.


*-----------------------------------
* UPDATE
*-----------------------------------

    UPDATE zdata_table_110
    SET marks = 85
    WHERE id = 1.

    IF sy-subrc = 0.
      out->write( 'Step 3: Marks updated successfully' ).
    ENDIF.

ls_student-id = 1.
ls_student-name = 'Alice'.
ls_student-marks = 30.
APPEND ls_student TO lt_students.

CLEAR ls_student.

ls_student-id = 2.
ls_student-name = 'Bob'.
ls_student-marks = 20.
APPEND ls_student TO lt_students.

CLEAR ls_student.

ls_student-id = 3.
ls_student-name = 'Charlie'.
ls_student-marks = 40.
APPEND ls_student TO lt_students.

CLEAR ls_student.

ls_student-id = 4.
ls_student-name = 'David'.
ls_student-marks = 50.
APPEND ls_student TO lt_students.

CLEAR ls_student.

ls_student-id = 5.
ls_student-name = 'Emma'.
ls_student-marks = 60.
APPEND ls_student TO lt_students.

MODIFY zdata_table_110 FROM TABLE @lt_students.

IF sy-subrc = 0.
  out->write( 'Step 1: Students inserted successfully' ).
ENDIF.

*-----------------------------------
* DELETE
*-----------------------------------

    DELETE FROM zdata_table_110
    WHERE id = 2.

    IF sy-subrc = 0.
      out->write( 'Step 4: Bob deleted successfully' ).
    ENDIF.


*-----------------------------------
* FINAL DISPLAY
*-----------------------------------

    SELECT *
    FROM zdata_table_110
    INTO TABLE @lt_students.

    out->write( 'Final Database State:' ).

    LOOP AT lt_students INTO ls_student.

      out->write(
      |ID: { ls_student-id } Name: { ls_student-name } Marks: { ls_student-marks }|
      ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
