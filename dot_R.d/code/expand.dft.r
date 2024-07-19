expand.dft <- function(x, na.strings = "NA", as.is = FALSE, dec = ".")
{
  # Take each row in the source data frame table and replicate it
  # using the Freq value
  DF <- sapply(1:nrow(x), function(i) x[rep(i, each = x$Freq[i]), ],
               simplify = FALSE)

  # Take the above list and rbind it to create a single DF
  # Also subset the result to eliminate the Freq column
  DF <- subset(do.call("rbind", DF), select = -Freq)

  # Now apply type.convert to the character coerced factor columns
  # to facilitate data type selection for each column
  DF <- as.data.frame(lapply(DF,
                             function(x)
                             type.convert(as.character(x),
                                          na.strings = na.strings,
                                          as.is = as.is,
                                          dec = dec)))

  # Return data frame
  DF
} 
