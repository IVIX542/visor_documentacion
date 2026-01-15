Add-Type -AssemblyName System.Drawing

function Generate-Icon {
    param (
        [int]$size,
        [string]$outputPath
    )
    
    $bmp = New-Object System.Drawing.Bitmap $size, $size
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    
    # Background Gradient (Indigo to Purple)
    $rect = New-Object System.Drawing.Rectangle 0, 0, $size, $size
    $c1 = [System.Drawing.ColorTranslator]::FromHtml("#6366f1")
    $c2 = [System.Drawing.ColorTranslator]::FromHtml("#a855f7")
    
    # Fix: Use ArgumentList for constructor
    $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush -ArgumentList $rect, $c1, $c2, 45.0
    
    $g.FillRectangle($brush, $rect)
    
    # Inner Circle (Semi-transparent white)
    $circleRect = New-Object System.Drawing.Rectangle ($size * 0.2), ($size * 0.2), ($size * 0.6), ($size * 0.6)
    $brushCircle = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(50, 255, 255, 255))
    $g.FillEllipse($brushCircle, $circleRect)
    
    # Triangle (White)
    $white = [System.Drawing.Color]::White
    $brushWhite = New-Object System.Drawing.SolidBrush $white
    # Approximate the arrow shape
    $pt1 = New-Object System.Drawing.Point ($size * 0.5), ($size * 0.25)
    $pt2 = New-Object System.Drawing.Point ($size * 0.68), ($size * 0.68)
    $pt3 = New-Object System.Drawing.Point ($size * 0.32), ($size * 0.68)
    
    $points = @($pt1, $pt2, $pt3)
    $g.FillPolygon($brushWhite, $points)
    
    $bmp.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose()
    $bmp.Dispose()
    
    Write-Host "Generated $outputPath"
}

Generate-Icon -size 192 -outputPath "c:\Users\razon\Documents\SPAaPWA\icon-192.png"
Generate-Icon -size 512 -outputPath "c:\Users\razon\Documents\SPAaPWA\icon-512.png"
