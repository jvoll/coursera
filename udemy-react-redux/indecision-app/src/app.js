class IndecisionApp extends React.Component {
    constructor(props) {
        super(props)

        this.handleAddOption = this.handleAddOption.bind(this)
        this.handleDeleteOptions = this.handleDeleteOptions.bind(this)
        this.handlePick = this.handlePick.bind(this)

        this.state = {
            options: props.options
        }
    }

    componentDidMount() {
        console.log('componentDidMount')
        console.log('fetching data')
    }

    componentDidUpdate(prevProps, prevState) {
        console.log('componentDidUpdate')
        console.log('saving data')
    }

    componentWillUnmount() {
        console.log('componentWillUnmount')
    }

    handleAddOption(option) {
        if (!option) {
            return 'Enter valid value to add item'
        } else if (this.state.options.indexOf(option) > -1) {
            return 'This option already exists'
        }

        fetch('http://localhost:3000/ideas/', {
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                idea: option
            })
        }).then((res) => {
            console.log(res)
            // Only half wired up, we're not ever actually loading data from the server yet
            return this.setState((prevState) => {
                return {
                    options: prevState.options.concat(option)
                }
            })
        })
    }

    handleDeleteOptions() {
        this.setState(() => {
            return {
                options: []
            }
        })
    }

    handlePick() {
        const randomIndex = Math.floor(Math.random() * this.state.options.length)
        alert(this.state.options[randomIndex])
    }

    render() {
        const subtitle = 'Put your life in the hands of a computer'

        return (
            <div>
                <Header subtitle={subtitle} />
                <Action handlePick={this.handlePick}
                    hasOptions={this.state.options.length > 0}/>
                <Options
                    options={this.state.options}
                    handleDeleteOptions={this.handleDeleteOptions}
                />
                <AddOption handleAddOption={this.handleAddOption} />
            </div>
        )
    }
}

IndecisionApp.defaultProps = {
    options: []
}

const Header = (props) => {
    return (
        <div>
            <h1>{props.title}</h1>
            {props.subtitle && <h2>{props.subtitle}</h2> }

        </div>
    )
}

Header.defaultProps = {
    title: 'Indecision'
}

const Action = (props) => {
    return (
        <div>
            <button disabled={!props.hasOptions} onClick={props.handlePick}>
                What should I do?
            </button>
        </div>
    )
}

const Options = (props) => {
    return (
        <div>
            <button onClick={props.handleDeleteOptions}>Remove All</button>
            {props.options.map((option, idx) => <Option optionText={option} key={idx} />)}
        </div>
    )
}

const Option = (props) => {
    return (
        <div>{props.optionText}</div>
    )
}

class AddOption extends React.Component {
    constructor(props) {
        super(props)
        this.handleAddOption = this.handleAddOption.bind(this)

        this.state = {
            error: ''
        }
    }

    handleAddOption(e) {
        e.preventDefault()
        const option = e.target.elements.option.value.trim()
        const error = this.props.handleAddOption(option)
        this.setState(() => {
            return { error }
        })
        e.target.elements.option.value = ''
    }

    render() {
        return (
            <div>
                {this.state.error &&
                    <p>{this.state.error}</p>
                }
                <form onSubmit={this.handleAddOption}>
                    <input type="text" name="option" />
                    <button>Add Option</button>
                </form>
            </div>
        )
    }
}

ReactDOM.render(<IndecisionApp />, document.getElementById('app'))