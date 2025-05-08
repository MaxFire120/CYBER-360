<#
  Program Name : color.ps1
  Date: 2025-05-07
  Author: Maxwell Imo and Myciah Russell
  Course: CYBER 360
  We, Maxwell Imo and Myciah Russell, affirm that we wrote this script as original work completed by us.
#>

$SystemColors = [System.Enum]::GetValues([System.ConsoleColor])

function Show-ValidColors {
  $show = Read-Host "Would you like to see the list of valid colors? (yes/no)"
  if ($show -eq 'yes') {
      Write-Host "Valid colors are:"
      $SystemColors | ForEach-Object { Write-Host $_ }
  } else {
      Write-Host "Okay, continuing without showing the color list."
  }
}

function Start-Game {
  $random = Get-Random -Minimum 0 -Maximum $SystemColors.Count
  $favoriteColor = $SystemColors[$random]

  $startTime = Get-Date
  $wrongGuesses = @()
  $guessCount = 0

  Write-Host "Guess my favorite color! (Type 'exit' to quit)"
  Show-ValidColors
  Write-Host "You can also type 'list' to see the colors again or 'hint' for a hint."

  while ($true) {
    Write-Host "`nWhat is my favorite color?"
    $input = Read-Host "Enter your guess"

    if ($input -eq 'exit') {
      Write-Host "Thanks for playing! Goodbye!" -ForegroundColor $favoriteColor
      break
    } elseif ($input -eq 'list') {
      Show-ValidColors
    } elseif ($input -eq 'hint') {
      if ($favoriteColor.ToString().StartsWith('Dark')) {
        $hint = "Dark" + $favoriteColor.ToString().Substring(4,1)
      } else {
        $hint = $favoriteColor.ToString().Substring(0,1)
      }
      Write-Host "Hint: The favorite color starts with '$hint'"
    } else {
      try {
        $guessColor = [System.ConsoleColor]$input
      } catch {
        Write-Host "'$input' is not a valid color. Use 'list' to see valid options."
        continue
      }

      $guessCount++

      if ($guessColor -eq $favoriteColor) {
        $endTime = Get-Date
        $timeTaken = ($endTime - $startTime).TotalSeconds
        Write-Host "Congratulations! You guessed my favorite color, which is " -NoNewline
        Write-Host "$favoriteColor" -ForegroundColor $favoriteColor
        Write-Host "It took you $guessCount guesses and $timeTaken seconds."
        break
      } else {
        Write-Host "Wrong guess! Try again." -ForegroundColor 'Red'
        if ($wrongGuesses -notcontains $input) {
          $wrongGuesses += $input
        }
      }
    }
  }

  if ($wrongGuesses.Count -gt 0) {
    Write-Host "`nYour incorrect guesses were:"
    $wrongGuesses | ForEach-Object { Write-Host $_ }
  }

  $playAgain = Read-Host "Would you like to play again? (yes/no)"

  if ($playAgain -eq "yes") {

      Start-Game

  } else {

      Write-Host "Thank you so much for playing! Have a good rest of your day!" -ForegroundColor Green

  }

}

Start-Game