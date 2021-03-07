let Map = https://prelude.dhall-lang.org/v15.0.0/Map/Type

let Keys = ./karabiner-keys.dhall

let ProfileConfig =
      { default : Bool
      , sim : Natural
      , delay : Natural
      , alone : Natural
      , held : Natural
      }

let Templates = Map Text Text

let LayerBinding = < KeyBinding : Keys.FromKey >

let KarabinerConfig =
      { profiles : Map Text ProfileConfig, templates : Templates }

in  KarabinerConfig
