handle_image() {
    local mimetype="${1}"
    case "${mimetype}" in
        # SVG
        image/svg+xml)
            convert "${FILE_PATH}" "${IMAGE_CACHE_PATH}" && exit 6
            exit 1;;

        # BEGIN SNIPPET
        image/x-canon-cr2|image/x-olympus-orf|image/tiff)
            local orientation
            # extract orientation from RAW file using exiftool (identify won't work)
            orientation=$( exiftool -b -Orientation "${FILE_PATH}")
            exiftool -b -PreviewImage "${FILE_PATH}" > "${IMAGE_CACHE_PATH}"
            if [[ -n "$orientation" && "$orientation" != 1 ]]; then
                # ...auto-rotate the image according to the EXIF data.
                exiftool -overwrite_original_in_place -Orientation="$orientation" -n "${IMAGE_CACHE_PATH}"
                mogrify -auto-orient "${IMAGE_CACHE_PATH}"
            fi
            exit 6;;
        # END SNIPPET

        # Image
        image/*)
            local orientation
            local orientation
            orientation="$( identify -format '%[EXIF:Orientation]\n' -- "${FILE_PATH}" )"
