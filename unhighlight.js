/*!
UnHighlight - Remove "?highlight=..." from urls
Copyright (C) 2020  Justin Bassett

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

// Based on Pure URL by VEG: https://addons.mozilla.org/en-US/firefox/addon/pure-url/
// which is licensed under GPL-v3, as is this extension.

browser.webRequest.onBeforeRequest.addListener(
    function(req)
    {
        var path = req.url
        var highlightPos = path.indexOf('?highlight=')
        if (highlightPos > -1)
        {
            var cleaned = path.substring(0, highlightPos)
            console.log('Stripping highlight: ', cleaned)

            return {redirectUrl: cleaned}
        }
    },
    {urls: ['https://*/*?*', 'http://*/*?*'], types: ['main_frame']}, ['blocking']);
