// const appRoot = document.getElementById('app')

// const myState = {
//     showingDetails: false
// }

// const onToggle = () => {
//     myState.showingDetails = !myState.showingDetails
//     render()
// }

// const render = () => {
//     const template = (
//         <div>
//             <h1>Visibility Toggle</h1>
//             <button onClick={onToggle}>{myState.showingDetails ? 'Hide Details' : 'Show Details'}</button>
//             {myState.showingDetails &&
//                 <div><p>A whole whack of detailed text! Top secret!</p></div>
//             }
//         </div>
//     )
//     ReactDOM.render(template, appRoot)
// }

// render()

class VisibilityToggle extends React.Component {
    constructor(props) {
        super(props)

        this.handleToggleVisibility = this.handleToggleVisibility.bind(this)

        this.state = {
            visibility: false
        }
    }

    handleToggleVisibility() {
        this.setState((prevState) => {
            return {
                visibility: !prevState.visibility
            }
        })
    }

    render() {
        return (
            <div>
                <h1>Visibility Toggle</h1>
                <button onClick={this.handleToggleVisibility}>
                    {this.state.visibility ? 'Hide Details' : 'Show Details'}
                </button>
                {this.state.visibility &&
                    <div><p>A whole whack of detailed text! Top secret!</p></div>
                }
            </div>
        )
    }
}

ReactDOM.render(<VisibilityToggle />, document.getElementById('app'))
