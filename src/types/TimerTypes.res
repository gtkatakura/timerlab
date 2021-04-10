type background =
  | Image(string)
  | Color(string)

type theme = {
  id: string,
  name: string,
  primaryColor: string,
  secondaryColor: string,
  background: background,
  default: bool,
  overlayColor: string,
  opacity: float,
}

type status =
  | IsCreating
  | IsEditing(string, ThemeForm.input)
  | Default

let makeBackground = x =>
  switch x {
  | (None, Some(image))
  | (Some(_), Some(image)) =>
    Image(image)
  | (None, None) => Color("#fff")
  | (Some(color), None) => Color(color)
  }

let fromThemeForm = (output: ThemeForm.output, id) => {
  id: id,
  name: output.name,
  primaryColor: output.primaryColor,
  secondaryColor: output.secondaryColor,
  background: makeBackground((output.backgroundColor, output.backgroundImage)),
  default: false,
  overlayColor: output.overlayColor,
  opacity: output.opacity,
}

let toInput: theme => ThemeForm.input = theme => {
  name: theme.name,
  primaryColor: theme.primaryColor,
  secondaryColor: theme.secondaryColor,
  overlayColor: theme.overlayColor,
  opacity: theme.opacity,
  backgroundColor: switch theme.background {
  | Color(color) => color
  | Image(_) => ""
  },
  backgroundImage: switch theme.background {
  | Color(_) => ""
  | Image(image) => image
  },
}
