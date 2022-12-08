COPY bevoelkerung FROM '$INST_PATH/db/bevoelkerung.parquet' (FORMAT 'parquet');
COPY bildung FROM '$INST_PATH/db/bildung.parquet' (FORMAT 'parquet');
COPY beschaeftigung_und_erwerbstaetigkeit FROM '$INST_PATH/db/beschaeftigung_und_erwerbstaetigkeit.parquet' (FORMAT 'parquet');
COPY bauen_und_wohnen FROM '$INST_PATH/db/bauen_und_wohnen.parquet' (FORMAT 'parquet');
COPY _regionen FROM '$INST_PATH/db/_regionen.parquet' (FORMAT 'parquet');
COPY _indikatoren FROM '$INST_PATH/db/_indikatoren.parquet' (FORMAT 'parquet');
COPY sdg FROM '$INST_PATH/db/sdg.parquet' (FORMAT 'parquet');
COPY medizinische_und_soziale_versorgung FROM '$INST_PATH/db/medizinische_und_soziale_versorgung.parquet' (FORMAT 'parquet');
COPY wirtschaft FROM '$INST_PATH/db/wirtschaft.parquet' (FORMAT 'parquet');
COPY europa FROM '$INST_PATH/db/europa.parquet' (FORMAT 'parquet');
COPY raumwirksame_mittel FROM '$INST_PATH/db/raumwirksame_mittel.parquet' (FORMAT 'parquet');
COPY flaechennutzung_und_umwelt FROM '$INST_PATH/db/flaechennutzung_und_umwelt.parquet' (FORMAT 'parquet');
COPY zom FROM '$INST_PATH/db/zom.parquet' (FORMAT 'parquet');
COPY arbeitslosigkeit FROM '$INST_PATH/db/arbeitslosigkeit.parquet' (FORMAT 'parquet');
COPY verkehr_und_erreichbarkeit FROM '$INST_PATH/db/verkehr_und_erreichbarkeit.parquet' (FORMAT 'parquet');
COPY sozialleistungen FROM '$INST_PATH/db/sozialleistungen.parquet' (FORMAT 'parquet');
COPY siedlungsstruktur FROM '$INST_PATH/db/siedlungsstruktur.parquet' (FORMAT 'parquet');
COPY oeffentliche_finanzen FROM '$INST_PATH/db/oeffentliche_finanzen.parquet' (FORMAT 'parquet');
COPY absolutzahlen FROM '$INST_PATH/db/absolutzahlen.parquet' (FORMAT 'parquet');
COPY privateinkommen_private_schulden FROM '$INST_PATH/db/privateinkommen_private_schulden.parquet' (FORMAT 'parquet');