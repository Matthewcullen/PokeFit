import React from 'react';
import Menu from './menu-drawer/menu';

export default class PokemonDetails extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      viewDetails: 'stats'
    };
    this.changeView = this.changeView.bind(this);
  }

  changeView(view) {
    this.setState({
      viewDetails: view
    });
  }

  render() {
    const pokemon = this.props.pokemon;
    let details;
    if (pokemon) {
      const viewDetails = this.state.viewDetails;
      const height = (this.props.pokemon.height / 3.048);
      const feet = Math.floor(height);
      const inches = Math.round((height - feet) * 12);
      const weight = Math.round((this.props.pokemon.weight / 4.536));
      switch (viewDetails) {
        case 'stats':
          details = (
            <div className="pokemon-desc" onClick={() => this.changeView('description')}>
              <div>{pokemon.species}</div>
              <div className='to-capitalize'>Type: {pokemon.type}</div>
              <div>{`Height: ${feet}'${inches}''`}</div>
              <div >{'Weight: '}<span className='weight'>{weight} lbs.</span></div>
            </div>
          );
          break;
        case 'description':
          details = (
            <div className="pokemon-desc" onClick={() => this.changeView('description-cont')}>
              <div className='to-capitalize'>Habitat: {pokemon.habitat}</div>
              <div>{pokemon.flavorText}</div>
            </div>
          );
          break;
        case 'description-cont':
          details = (
            <div className="pokemon-desc" onClick={() => this.changeView('stats')}>
              <div>{pokemon.flavorTextNew}</div>
            </div>
          );
          break;
      }
      return (
        <div className="pokedex-screen-container">
          <div className="pokedex-display-screen" style={{ backgroundImage: `url(${this.props.backgroundImage})` }} >
            <div className="top-screen-first-row">
              <Menu pokemon={pokemon}
                setView={this.props.setView}
                getPokemon={this.props.getPokemon}
                timeOfDay={this.props.timeOfDay}
                className="menu-button"
                openDrawer={this.props.openDrawer}
                closeDrawer={this.props.closeDrawer}
                setAction={this.props.setAction}
                opened={this.props.opened}
                setPokemonDetails={this.props.setPokemonDetails}
                action={this.props.action}/>
              <div className='pokemon-ball-title' style={{ backgroundImage: `url(${pokemon.ballSprite})` }} />
              <div className="top-screen-title to-uppercase">{pokemon.name}</div>
            </div>
            <div className="top-screen-second-row" onClick={() => {
              this.props.setAction(null);
              this.props.closeDrawer();
            }}>
              <div className="top-screen-picture" style={{ backgroundImage: `url(${pokemon.spriteFrontDefault})` }} />
              {details}
            </div>
          </div>
        </div>
      );
    } else {
      return (
        <div className="pokedex-screen-container">
          <div className="pokedex-display-screen" style={{ backgroundImage: `url(${this.props.backgroundImage})` }}>
            <div className="top-display-header" style={{ backgroundColor: 'yellow' }}>GO CATCH SOME POKéMON!</div>
          </div>
        </div>
      );
    }
  }
}
