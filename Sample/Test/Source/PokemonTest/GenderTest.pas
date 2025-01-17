unit GenderTest;

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
  Gender.Entity;

type

  [TestFixture]
  TGenderTest = class
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

procedure TGenderTest.Setup;
begin
  FPokeWrapper := TPokeFactory.New(integer(TPokemon.Gender));
end;

procedure TGenderTest.TestEntity;
var
  LGenderEntity: TGenderEntity;
begin
  Write('Testing TPokemon.gender .');
  for var I: integer := 1 to 3 do
  begin
    LGenderEntity := nil;
    try
      LGenderEntity := TGenderEntity.Create;
      FPokeWrapper.GetAsEntity(LGenderEntity, I);
      // Assertions
      Assert.IsNotEmpty(LGenderEntity.id);
      Assert.IsNotEmpty(LGenderEntity.name);
      // Node Names
      if LGenderEntity.pokemon_species_details.Count > 0 then
      begin
        Assert.IsNotEmpty(LGenderEntity.pokemon_species_details.Items[0].pokemon_species.name);
        Assert.IsNotEmpty(LGenderEntity.pokemon_species_details.Items[0].pokemon_species.url);
        Assert.IsNotEmpty(LGenderEntity.pokemon_species_details.Items[0].rate);
      end;
      // Node Pokemon Species
      if LGenderEntity.required_for_evolution.Count > 0 then
      begin
        Assert.IsNotEmpty(LGenderEntity.required_for_evolution.Items[0].name);
        Assert.IsNotEmpty(LGenderEntity.required_for_evolution.Items[0].url);
      end;
      Write('.');
    finally
      LGenderEntity.Free;
    end;
  end;
  Assert.WillRaise(TestEntityWillRaise);
  Write('Finished.');
end;

procedure TGenderTest.TestEntityWillRaise;
var
  LGenderEntity: TGenderEntity;
begin
  LGenderEntity := nil;
  try
    LGenderEntity := TGenderEntity.Create;
    FPokeWrapper.GetAsEntity(LGenderEntity, 9999999);
  finally
    LGenderEntity.Free;
  end;
end;

procedure TGenderTest.TestList;
var
  LPokeListEntity: TPokeListEntity;
begin
  LPokeListEntity := nil;
  try
    Write('Testing List of TPokemon.gender...  ');
    LPokeListEntity := FPokeWrapper.GetAsListEntity;
    Assert.IsNotEmpty(LPokeListEntity.Count);
    FList := LPokeListEntity.Count;
    Write('Finished.');
  finally
    LPokeListEntity.Free;
  end;
end;

initialization

TDUnitX.RegisterTestFixture(TGenderTest);

end.
