unit VersionTest;

interface

uses
  System.SysUtils,
  //
  DUnitX.TestFramework,
  // PokeAPI
  PokeFactory,
  PokeWrapper,
  PokeWrapper.Interfaces,
  PokeWrapper.Types,
  //
  PokeList.Entity,
  Version.Entity;

type

  [TestFixture]
  TVersionTest = class
  private
    FPokeWrapper: IPokeWrapper;
    FList: integer;
  public
    [Setup]
    procedure Setup;
    [Test]
    procedure TestList;
    [Test]
    procedure TestEntity;
    procedure TestEntityWillRaise;
  end;

implementation

procedure TVersionTest.Setup;
begin
  FPokeWrapper := TPokeFactory.New(integer(TPokemon.Version));
end;

procedure TVersionTest.TestEntity;
var
  LVersionEntity: TVersionEntity;
begin
  Write('Testing TGames.version .');
  for var I: integer := 1 to 10 do
  begin
    LVersionEntity := nil;
    try
      // Id pokedex 10 not found
      if I <> 10 then
      begin
        LVersionEntity := TVersionEntity.Create;
        FPokeWrapper.GetAsEntity(LVersionEntity, I);
        // Assertions
        Assert.IsNotEmpty(LVersionEntity.id);
        Assert.IsNotEmpty(LVersionEntity.name);
        // node Language
        Assert.IsNotEmpty(LVersionEntity.names.Items[LVersionEntity.names.Count - 1].language.name);
        Assert.IsNotEmpty(LVersionEntity.names.Items[LVersionEntity.names.Count - 1].language.url);
        Assert.IsNotEmpty(LVersionEntity.names.Items[LVersionEntity.names.Count - 1].name);
        // node version_group
        Assert.IsNotEmpty(LVersionEntity.version_group.name);
        Assert.IsNotEmpty(LVersionEntity.version_group.url);
        Write('.');
      end;
    finally
      LVersionEntity.Free;
    end;
  end;
  Assert.WillRaise(TestEntityWillRaise);
  Write('Finished.');
end;

procedure TVersionTest.TestEntityWillRaise;
var
  LVersionEntity: TVersionEntity;
begin
  LVersionEntity := nil;
  try
    LVersionEntity := TVersionEntity.Create;
    FPokeWrapper.GetAsEntity(LVersionEntity, 9999999);
  finally
    LVersionEntity.Free;
  end;
end;

procedure TVersionTest.TestList;
var
  LPokeListEntity: TPokeListEntity;
begin
  LPokeListEntity := nil;
  try
    Write('Testing List of TGames.version...  ');
    LPokeListEntity := FPokeWrapper.GetAsListEntity;
    Assert.IsNotEmpty(LPokeListEntity.Count);
    FList := LPokeListEntity.Count;
    Write('Finished.');
  finally
    LPokeListEntity.Free;
  end;
end;

initialization

TDUnitX.RegisterTestFixture(TVersionTest);

end.
