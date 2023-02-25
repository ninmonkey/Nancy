class ConsoleCell {
    <#
    .SYNOPSIS
        Consists of one cell, or at least one glyph, with color
    #>
    [object]$FG = 'gray80'
    [object]$BG = 'gray30'
    [string]$Text = '_'

    # renders, then writes to console at the current location
    [void] Write() {
        $msg = $this.Render()
        [console]::Write( $msg )
    }

    # Renders as ansi escape sequence
    [string] Render() {
        # future: remove Pansies dependency as $PSStle?
        $msg = New-Text -fg $this.FG -bg $this.BG -Text $this.Text
        return $msg.ToString()
    }

    [string] ToString() {
        $msg = '[ConsoleCell(Text={0}, FG={1}, BG={2})] = "{3}"' -f @(
            $this.Text
            $this.FG
            $this.BG
            $this.Render()
        )
        $msg | Write-Debug
        return $msg
        # return $this.Render()
    }
}
class ConsolePosition {
    <#
    .SYNOPSIS
        minimal (x,y) tuple  metadata for console stuff
    .NOTES
        once
    #>
    [int]$X = 0
    [int]$Y = 0

    ConsolePosition () {
        $This.X = 0 ; $this.Y = 0
    }
    ConsolePosition ([int]$X, [int]$Y) {
        $this.X = $X
        $this.Y = $Y
    }

    [void] ConstrainTo ( [ConsoleRect]$RectConstraint) {
        'Constrain {0} to exist within {1}' -f @(
            $This.ToString()
            $RectConstraint.ToString()
        ) | Write-Debug

        if ($This.X -lt $RectConstraint.X) {
            $This.X = $RectConstraint.X
        } elseif ($This.X -gt $RectConstraint.Right) {
            $this.X = $RectConstraint.Right
        }
        if ($This.Y -lt $RectConstraint.Y) {
            $This.Y = $RectConstraint.Y
        } elseif ($This.Y -gt $RectConstraint.Bottom) {
            $this.Y = $RectConstraint.Bottom
        }

        'NewPosition = {0}' -f @(
            $this.ToString()
        ) | Write-Debug
    }

    [string] ToString() {
        return '[ConsolePosition({0}, {1})]' -f @(
            $this.X
            $this.Y
        )
    }
}
class ConsoleRect {
    <#
    .SYNOPSIS
        minimal rect-like metadata for console stuff
    .NOTES
        todo:
            - [ ] make getter/setter .Right using cs probably
    .EXAMPLE
        PS> [ConsoleRect]::new()
        PS> $cr = [ConsoleRect]::new(0,2,3,4)

        PS> $cr.ToString()

            [ConsoleRect(0, 2, 3, 4)]


    #>
    [int]$X = 0
    [int]$Y = 0
    [uint]$Width = 1
    [uint]$Height = 1

    ConsoleRect () {
        $This.X = 0 ; $This.Y = 0; $this.Width = 1; $this.Height = 1
    }
    ConsoleRect ([int]$X, [int]$Y, [int]$Width, [int]$Height) {
        $this.X = $X
        $this.Y = $Y
        $this.Width = $Width
        $this.Height = $Height
    }
    [int] Right() {
        return ($this.X + $this.Width)
    }
    [int] Bottom() {
        return ($this.X + $this.Width)
    }

    [bool] ContainsPoint( [ConsolePosition]$Position ) {
        [bool]$allTrue = (
            (
                $Position.X -ge $This.X
            ) -and (
                $Position.X -lt $this.Right()
            ) -and (
                $Position.Y -ge $This.Y
            ) -and (
                $Position.Y -lt $This.Bottom()
            )
        )
        return $allTrue
    }
    # calculated props:
    # [bool] ContainsPoint ( [ConsolePosition]$Position ) {

    # }

    [string] ToString () {
        return '[ConsoleRect({0}, {1}, {2}, {3})]' -f @(
            $this.X
            $this.Y
            $this.Width
            $This.Height
        )
    }
}