/***********************************************************************/
/** Auto Ignite Lights
/** Lights candles, torches and any other light source Igni can light
/** within a fixed radius of the player, the same way an Igni hit would.
/**
/** Requires game version 4.04a or newer (script annotations).
/** No vanilla script files are edited, so Script Merger has nothing
/** to merge for this mod.
/***********************************************************************/

// Radius around the player, in meters, in which lights are ignited.
function AIL_Radius() : float			{ return 10.0; }

// Seconds between two scans of the surroundings.
function AIL_Interval() : float			{ return 1.0; }

// Upper bound on entities returned by a single scan.
function AIL_MaxResults() : int			{ return 1000; }


@wrapMethod(CR4Player)
function OnSpawned( spawnData : SEntitySpawnData )
{
	var ret : bool;

	ret = wrappedMethod( spawnData );
	AddTimer( 'AIL_IgniteNearbyLights', AIL_Interval(), true );
	return ret;
}

@addMethod(CR4Player)
timer function AIL_IgniteNearbyLights( dt : float, id : int )
{
	var entities : array< CGameplayEntity >;
	var lights : array< CComponent >;
	var lightComp : CGameplayLightComponent;
	var raining : bool;
	var i, j : int;

	// Leave staged lighting in dialogues and cutscenes alone.
	if( theGame.IsDialogOrCutscenePlaying() || theGame.IsFading() )
	{
		return;
	}

	raining = GetRainStrength() > 0.1;

	FindGameplayEntitiesInRange( entities, this, AIL_Radius(), AIL_MaxResults() );

	for( i = 0; i < entities.Size(); i += 1 )
	{
		// Some props carry more than one light, so check every one of them.
		lights = entities[i].GetComponentsByClassName( 'CGameplayLightComponent' );
		for( j = 0; j < lights.Size(); j += 1 )
		{
			lightComp = (CGameplayLightComponent)lights[j];
			if( !lightComp || lightComp.IsLightOn() )
			{
				continue;
			}

			// Rain puts these out; relighting them would just flicker.
			if( raining && lightComp.IsAffectedByWeather() )
			{
				continue;
			}

			if( lightComp.IsInteractive() )
			{
				// Same call Igni makes.
				lightComp.IgniHit();
			}
			else if( lightComp.IsEnabled() )
			{
				// Igni can't light this one, but its interact prompt is on,
				// so Geralt could still light it by hand.
				lightComp.SetLight( true );
			}
		}
	}
}
