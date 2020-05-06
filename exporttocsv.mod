

    execute
    {
    // turn an OPL tupleset into a csv file
    function turnTuplesetIntoCSV(tupleSet,csvFileName)
    {
    var f=new IloOplOutputFile(csvFileName);

    var quote="\"";
    var nextline="\\\n";

    var nbFields=tupleSet.getNFields();
    for(var j=0;j<nbFields;j++) f.write(tupleSet.getFieldName(j),";");
    f.writeln();
    for(var i in tupleSet)
    {

     

    for(var j=0;j<nbFields;j++)
    {

    var value=i[tupleSet.getFieldName(j)];
    if (typeof(value)=="string") f.write(quote);
    f.write(value);
    if (typeof(value)=="string") f.write(quote);
    f.write(";");

    }
    f.writeln();
    }
    f.close();
    }
    }


    tuple t
    {
    string firstname;
    int number;
    }

    {t} s={<"Nicolas",2>,<"Alexander",3>};

    execute
    {
    turnTuplesetIntoCSV(s,"export.csv");
    }

