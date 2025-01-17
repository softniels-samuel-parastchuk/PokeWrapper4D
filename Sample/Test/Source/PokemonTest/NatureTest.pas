unit NatureTest;

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
  Nature.Entity;

type

  [TestFixture]
  TNatureTest = class
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

procedure TNatureTest.Setup;
begin
  FPokeWrapper := TPokeFactory.New(integer(TPokemon.Nature));
end;

procedure TNatureTest.TestEntity;
var
  LNatureEntity: TNatureEntity;
begin
  Write('Testing TPokemon.nature .');
  for var I: integer := 1 to FList - 1 do
  begin
    LNatureEntity := nil;
    try
      LNatureEntity := TNatureEntity.Create;
      FPokeWrapper.GetAsEntity(LNatureEntity, I);
      // Assertions
      Assert.IsNotEmpty(LNatureEntity.id);
      // Node Move Battle Style Preferences
      if LNatureEntity.move_battle_style_preferences.Count > 0 then
      begin
        Assert.IsNotEmpty(LNatureEntity.move_battle_style_preferences.Items[0].high_hp_preference);
        Assert.IsNotEmpty(LNatureEntity.move_battle_style_preferences.Items[0].low_hp_preference);
        Assert.IsNotEmpty(LNatureEntity.move_battle_style_preferences.Items[0].move_battle_style.name);
        Assert.IsNotEmpty(LNatureEntity.move_battle_style_preferences.Items[0].move_battle_style.url);
      end;
      Assert.IsNotEmpty(LNatureEntity.name);
      // Node Names
      if LNatureEntity.names.Count > 0 then
      begin
        Assert.IsNotEmpty(LNatureEntity.names.Items[0].language.name);
        Assert.IsNotEmpty(LNatureEntity.names.Items[0].language.url);
        Assert.IsNotEmpty(LNatureEntity.names.Items[0].name);
      end;
      // Node Pokeathlon Stat Changes
      if LNatureEntity.pokeathlon_stat_changes.Count > 0 then
      begin
        Assert.IsNotEmpty(LNatureEntity.pokeathlon_stat_changes.Items[0].max_change);
        Assert.IsNotEmpty(LNatureEntity.pokeathlon_stat_changes.Items[0].pokeathlon_stat.name);
        Assert.IsNotEmpty(LNatureEntity.pokeathlon_stat_changes.Items[0].pokeathlon_stat.url);
      end;
      // Node Levels
      Write('.');
    finally
      LNatureEntity.Free;
    end;
  end;
  Assert.WillRaise(TestEntityWillRaise);
  Write('Finished.');
end;

procedure TNatureTest.TestEntityWillRaise;
var
  LNatureEntity: TNatureEntity;
begin
  LNatureEntity := nil;
  try
    LNatureEntity := TNatureEntity.Create;
    FPokeWrapper.GetAsEntity(LNatureEntity, 9999999);
  finally
    LNatureEntity.Free;
  end;
end;

procedure TNatureTest.TestList;
var
  LPokeListEntity: TPokeListEntity;
begin
  LPokeListEntity := nil;
  try
    Write('Testing List of TPokemon.nature...  ');
    LPokeListEntity := FPokeWrapper.GetAsListEntity;
    Assert.IsNotEmpty(LPokeListEntity.Count);
    FList := LPokeListEntity.Count;
    Write('Finished.');
  finally
    LPokeListEntity.Free;
  end;
end;

initialization

TDUnitX.RegisterTestFixture(TNatureTest);

end.
