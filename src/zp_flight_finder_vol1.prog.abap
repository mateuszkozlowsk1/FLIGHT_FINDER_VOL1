*&---------------------------------------------------------------------*
*& Report zp_flight_finder_vol1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zp_flight_finder_vol1.

PARAMETERS: pa_fldat TYPE sflight-fldate,
            pa_cifr  TYPE spfli-cityfrom,
            pa_cito  TYPE spfli-cityto,
            pa_cidp  TYPE spfli-countryfr.

TYPES: BEGIN OF ty_flight_finder,
         fldate    TYPE sflight-fldate,
         cityfrom  TYPE spfli-cityfrom,
         cityto    TYPE spfli-cityto,
         countryfr TYPE spfli-countryfr.
TYPES: END OF ty_flight_finder.

DATA: lt_flight_finder TYPE STANDARD TABLE OF ty_flight_finder.


SELECT * FROM
sflight INNER JOIN spfli
ON sflight~carrid = spfli~carrid AND
sflight~connid = spfli~connid
WHERE
fldate = @pa_fldat AND
cityfrom = @pa_cifr AND
cityto = @pa_cito AND
countryfr = @pa_cidp
INTO CORRESPONDING FIELDS OF TABLE @lt_flight_finder.

cl_demo_output=>display(
EXPORTING
data = lt_flight_finder
name = CONV #( TEXT-001 )
).
