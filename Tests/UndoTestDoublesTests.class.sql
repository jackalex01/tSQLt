EXEC tSQLt.NewTestClass 'UndoTestDoublesTests';
GO
CREATE PROCEDURE UndoTestDoublesTests.[test doesn't fail if there's no test double in the database]
AS
BEGIN

  EXEC tSQLt.ExpectNoException;
  
  EXEC tSQLt.UndoTestDoubles;

END;
GO
CREATE PROCEDURE UndoTestDoublesTests.[test restores a faked table]
AS
BEGIN
  CREATE TABLE UndoTestDoublesTests.aSimpleTable 
  (
    Id INT
  );

  DECLARE @OriginalObjectId INT = OBJECT_ID('UndoTestDoublesTests.aSimpleTable');

  EXEC tSQLt.FakeTable @TableName = 'UndoTestDoublesTests.aSimpleTable';

  EXEC tSQLt.UndoTestDoubles;

  DECLARE @RestoredObjectId INT = OBJECT_ID('UndoTestDoublesTests.aSimpleTable');
  EXEC tSQLt.AssertEquals @Expected = @OriginalObjectId, @Actual = @RestoredObjectId;

END;
GO
/*--
TODO
- ApplyConstraint
- ApplyTrigger

Also, just review all the code.

--*/
