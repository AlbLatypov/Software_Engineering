# Linux commands to display your hardware information


<table border="1" cellpadding="2" cellspacing="2">
<tbody>
<tr>
<td valign="top">Display info about all hardware</td>
<td valign="top"><strong>inxi -Fxz</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<em>--or--</em><br><br>
			<strong>hwinfo --short</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<em>--or--</em><br><br>
			<strong>lshw&nbsp; -short</strong></td>
</tr>
<tr>
<td valign="top">Display all CPU info</td>
<td valign="top"><strong>lscpu</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<em>--or--</em><br><br>
			<strong>lshw -C cpu</strong></td>
</tr>
<tr>
<td valign="top">Show CPU features&nbsp;(e.g., PAE, SSE2)</td>
<td valign="top"><strong>lshw -C cpu | grep -i capabilities</strong></td>
</tr>
<tr>
<td valign="top">Report whether the CPU is 32- or 64-bit</td>
<td valign="top"><strong>lshw -C cpu | grep -i width</strong></td>
</tr>
<tr>
<td valign="top">Show current memory size and configuration</td>
<td valign="top"><strong>dmidecode -t memory | grep -i size</strong>&nbsp;&nbsp;&nbsp;&nbsp;<em>--or--</em><br><br>
			<strong>lshw -short -C memory</strong></td>
</tr>
<tr>
<td valign="top">Show maximum memory for the hardware</td>
<td valign="top"><strong>dmidecode -t memory | grep -i max</strong></td>
</tr>
<tr>
<td valign="top">Determine whether memory slots are available</td>
<td valign="top"><strong>lshw -short -C memory | grep -i empty</strong><br><br>
			(a null answer means no slots available)</td>
</tr>
<tr>
<td valign="top">Determine the amount of video memory</td>
<td valign="top"><strong>lspci | grep -i vga</strong><br><br>
			then reissue with the device number;<br><br>
			for example:&nbsp; <strong>lspci -v -s 00:02.0</strong><br><br>
			The VRAM is the&nbsp;<em>prefetchable</em>&nbsp;value.</td>
</tr>
<tr>
<td valign="top">Show current memory use</td>
<td valign="top"><strong>free -m</strong> &nbsp;&nbsp;&nbsp;<em>--or--</em><br><br>
			<strong>top</strong></td>
</tr>
<tr>
<td valign="top">List the disk drives</td>
<td valign="top"><strong>lshw -short -C disk</strong></td>
</tr>
<tr>
<td valign="top">Show detailed information about a specific disk drive</td>
<td valign="top"><strong>hdparm -i /dev/sda</strong><br><br>
			(replace&nbsp;<strong>sda</strong>&nbsp;if necessary)</td>
</tr>
<tr>
<td valign="top">List information about disks and partitions</td>
<td valign="top"><strong>lsblk&nbsp;</strong>&nbsp;&nbsp;&nbsp;&nbsp; (simple)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<em>--or--</em><br><br>
			<strong>fdisk -l</strong>&nbsp;&nbsp; (detailed)</td>
</tr>
<tr>
<td valign="top">List partition IDs (UUIDs)</td>
<td valign="top"><strong>blkid</strong></td>
</tr>
<tr>
<td valign="top">List mounted filesystems, their mount points,<br><br>
			and megabytes used and available for each</td>
<td valign="top"><strong>df -m</strong></td>
</tr>
<tr>
<td valign="top">List USB devices</td>
<td valign="top"><strong>lsusb</strong></td>
</tr>
<tr>
<td valign="top">List PCI devices</td>
<td valign="top"><strong>lspci</strong></td>
</tr>
<tr>
<td valign="top">Show network card details</td>
<td valign="top"><strong>lshw -C network</strong></td>
</tr>
<tr>
<td valign="top">Show network interfaces</td>
<td valign="top"><strong>ifconfig -a</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<em>--or--</em><br><br>
			<strong>ip link show&nbsp;&nbsp;&nbsp;</strong><em>--or--</em><br><br>
			<strong>netstat -i</strong></td>
</tr>
<tr>
<td valign="top">Display routing tables</td>
<td valign="top"><strong>ip route | column -t<code><code>&nbsp;&nbsp;</code></code></strong><em>--or--</em><br><br>
			<strong>netstat -r</strong></td>
</tr>
<tr>
<td valign="top">Display UEFI/BIOS info</td>
<td valign="top"><strong>dmidecode -t bios</strong></td>
</tr>
<tr>
<td valign="top">Show kernel version, network hostname, more</td>
<td valign="top"><strong>uname -a</strong></td>
</tr>
</tbody>
</table>
