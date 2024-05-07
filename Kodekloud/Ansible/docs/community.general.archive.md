# community.general.archive module


<h1>community.general.archive module – Creates a compressed archive of one or more files or trees<a class="headerlink" href="#community-general-archive-module-creates-a-compressed-archive-of-one-or-more-files-or-trees" title="Permalink to this heading"></a></h1>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>This module is part of the <a class="reference external" href="https://galaxy.ansible.com/ui/repo/published/community/general/">community.general collection</a> (version 8.6.0).</p>
<p>You might already have this collection installed if you are using the <code class="docutils literal notranslate"><span class="pre">ansible</span></code> package.
It is not included in <code class="docutils literal notranslate"><span class="pre">ansible-core</span></code>.
To check whether it is installed, run <code class="code docutils literal notranslate"><span class="pre">ansible-galaxy</span> <span class="pre">collection</span> <span class="pre">list</span></code>.</p>
<p>To install it, use: <code class="code docutils literal notranslate"><span class="pre">ansible-galaxy</span> <span class="pre">collection</span> <span class="pre">install</span> <span class="pre">community.general</span></code>.
You need further requirements to be able to use this module,
see <a class="reference internal" href="#ansible-collections-community-general-archive-module-requirements"><span class="std std-ref">Requirements</span></a> for details.</p>
<p>To use it in a playbook, specify: <code class="code docutils literal notranslate"><span class="pre">community.general.archive</span></code>.</p>
</div>
<nav class="contents local" id="contents">
<ul class="simple">
<li><p><a class="reference internal" href="#synopsis" id="id1">Synopsis</a></p></li>
<li><p><a class="reference internal" href="#requirements" id="id2">Requirements</a></p></li>
<li><p><a class="reference internal" href="#parameters" id="id3">Parameters</a></p></li>
<li><p><a class="reference internal" href="#attributes" id="id4">Attributes</a></p></li>
<li><p><a class="reference internal" href="#notes" id="id5">Notes</a></p></li>
<li><p><a class="reference internal" href="#see-also" id="id6">See Also</a></p></li>
<li><p><a class="reference internal" href="#examples" id="id7">Examples</a></p></li>
<li><p><a class="reference internal" href="#return-values" id="id8">Return Values</a></p></li>
</ul>
</nav>
<section id="synopsis">
<h2><a class="toc-backref" href="#id1" role="doc-backlink">Synopsis</a><a class="headerlink" href="#synopsis" title="Permalink to this heading"></a></h2>
<ul class="simple">
<li><p>Creates or extends an archive.</p></li>
<li><p>The source and archive are on the remote host, and the archive <em>is not</em> copied to the local host.</p></li>
<li><p>Source files can be deleted after archival by specifying <code class="ansible-option-value docutils literal notranslate"><a class="reference internal" href="#ansible-collections-community-general-archive-module-parameter-remove"><span class="std std-ref"><span class="pre">remove=True</span></span></a></code>.</p></li>
</ul>
<p>Aliases: files.archive</p>
</section>
<section id="requirements">
<span id="ansible-collections-community-general-archive-module-requirements"></span><h2><a class="toc-backref" href="#id2" role="doc-backlink">Requirements</a><a class="headerlink" href="#requirements" title="Permalink to this heading"></a></h2>
<p>The below requirements are needed on the host that executes this module.</p>
<ul class="simple">
<li><p>Requires <code class="docutils literal notranslate"><span class="pre">lzma</span></code> (standard library of Python 3) or <a class="reference external" href="https://pypi.org/project/backports.lzma/">backports.lzma</a> (Python 2) if using <code class="docutils literal notranslate"><span class="pre">xz</span></code> format.</p></li>
</ul>
</section>
<section id="parameters">
<h2><a class="toc-backref" href="#id3" role="doc-backlink">Parameters</a><a class="headerlink" href="#parameters" title="Permalink to this heading"></a></h2>
<div class="wy-table-responsive"><table class="longtable ansible-option-table docutils align-default" style="width: 100%">
<thead>
<tr class="row-odd"><th class="head"><p>Parameter</p></th>
<th class="head"><p>Comments</p></th>
</tr>
</thead>
<tbody>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-attributes"></div>
<div class="ansibleOptionAnchor" id="parameter-attr"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-attributes"><span id="ansible-collections-community-general-archive-module-parameter-attr"></span><strong>attributes</strong></p>
<a class="ansibleOptionLink" href="#parameter-attributes" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-aliases">aliases: attr</span></p>
<p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The attributes the resulting filesystem object should have.</p>
<p>To get supported flags look at the man page for <em>chattr</em> on the target system.</p>
<p>This string should contain the attributes in the same order as the one displayed by <em>lsattr</em>.</p>
<p>The <code class="docutils literal notranslate"><span class="pre">=</span></code> operator is assumed as default, otherwise <code class="docutils literal notranslate"><span class="pre">+</span></code> or <code class="docutils literal notranslate"><span class="pre">-</span></code> operators need to be included in the string.</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-dest"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-dest"><strong>dest</strong></p>
<a class="ansibleOptionLink" href="#parameter-dest" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">path</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The file name of the destination archive. The parent directory must exists on the remote host.</p>
<p>This is required when <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-community-general-archive-module-parameter-path"><span class="std std-ref"><span class="pre">path</span></span></a></strong></code> refers to multiple files by either specifying a glob, a directory or multiple paths in a list.</p>
<p>If the destination archive already exists, it will be truncated and overwritten.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-exclude_path"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-exclude-path"><strong>exclude_path</strong></p>
<a class="ansibleOptionLink" href="#parameter-exclude_path" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">list</span> / <span class="ansible-option-elements">elements=path</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Remote absolute path, glob, or list of paths or globs for the file or files to exclude from <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-community-general-archive-module-parameter-path"><span class="std std-ref"><span class="pre">path</span></span></a></strong></code> list and glob expansion.</p>
<p>Use <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-community-general-archive-module-parameter-exclusion-patterns"><span class="std std-ref"><span class="pre">exclusion_patterns</span></span></a></strong></code> to instead exclude files or subdirectories below any of the paths from the <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-community-general-archive-module-parameter-path"><span class="std std-ref"><span class="pre">path</span></span></a></strong></code> list.</p>
<p class="ansible-option-line"><strong class="ansible-option-default-bold">Default:</strong> <code class="ansible-option-default docutils literal notranslate"><span class="pre">[]</span></code></p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-exclusion_patterns"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-exclusion-patterns"><strong>exclusion_patterns</strong></p>
<a class="ansibleOptionLink" href="#parameter-exclusion_patterns" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">list</span> / <span class="ansible-option-elements">elements=path</span></p>
<p><em class="ansible-option-versionadded">added in community.general 3.2.0</em></p>
</div></td>
<td><div class="ansible-option-cell"><p>Glob style patterns to exclude files or directories from the resulting archive.</p>
<p>This differs from <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-community-general-archive-module-parameter-exclude-path"><span class="std std-ref"><span class="pre">exclude_path</span></span></a></strong></code> which applies only to the source paths from <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-community-general-archive-module-parameter-path"><span class="std std-ref"><span class="pre">path</span></span></a></strong></code>.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-force_archive"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-force-archive"><strong>force_archive</strong></p>
<a class="ansibleOptionLink" href="#parameter-force_archive" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">boolean</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Allows you to force the module to treat this as an archive even if only a single file is specified.</p>
<p>By default when a single file is specified it is compressed only (not archived).</p>
<p>Enable this if you want to use <a class="reference internal" href="../../ansible/builtin/unarchive_module.html#ansible-collections-ansible-builtin-unarchive-module"><span class="std std-ref">ansible.builtin.unarchive</span></a> on an archive of a single file created with this module.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">false</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">true</span></code></p></li>
</ul>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-format"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-format"><strong>format</strong></p>
<a class="ansibleOptionLink" href="#parameter-format" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The type of compression to use.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">"bz2"</span></code></p></li>
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">"gz"</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">"tar"</span></code></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">"xz"</span></code></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">"zip"</span></code></p></li>
</ul>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-group"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-group"><strong>group</strong></p>
<a class="ansibleOptionLink" href="#parameter-group" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Name of the group that should own the filesystem object, as would be fed to <em>chown</em>.</p>
<p>When left unspecified, it uses the current group of the current user unless you are root, in which case it can preserve the previous ownership.</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-mode"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-mode"><strong>mode</strong></p>
<a class="ansibleOptionLink" href="#parameter-mode" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">any</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The permissions the resulting filesystem object should have.</p>
<p>For those used to <em>/usr/bin/chmod</em> remember that modes are actually octal numbers. You must give Ansible enough information to parse them correctly. For consistent results, quote octal numbers (for example, <code class="ansible-value docutils literal notranslate"><span class="pre">'644'</span></code> or <code class="ansible-value docutils literal notranslate"><span class="pre">'1777'</span></code>) so Ansible receives a string and can do its own conversion from string into number. Adding a leading zero (for example, <code class="ansible-value docutils literal notranslate"><span class="pre">0755</span></code>) works sometimes, but can fail in loops and some other circumstances.</p>
<p>Giving Ansible a number without following either of these rules will end up with a decimal number which will have unexpected results.</p>
<p>As of Ansible 1.8, the mode may be specified as a symbolic mode (for example, <code class="ansible-value docutils literal notranslate"><span class="pre">u+rwx</span></code> or <code class="ansible-value docutils literal notranslate"><span class="pre">u=rw,g=r,o=r</span></code>).</p>
<p>If <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-community-general-archive-module-parameter-mode"><span class="std std-ref"><span class="pre">mode</span></span></a></strong></code> is not specified and the destination filesystem object <strong>does not</strong> exist, the default <code class="docutils literal notranslate"><span class="pre">umask</span></code> on the system will be used when setting the mode for the newly created filesystem object.</p>
<p>If <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-community-general-archive-module-parameter-mode"><span class="std std-ref"><span class="pre">mode</span></span></a></strong></code> is not specified and the destination filesystem object <strong>does</strong> exist, the mode of the existing filesystem object will be used.</p>
<p>Specifying <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-community-general-archive-module-parameter-mode"><span class="std std-ref"><span class="pre">mode</span></span></a></strong></code> is the best way to ensure filesystem objects are created with the correct permissions. See CVE-2020-1736 for further details.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-owner"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-owner"><strong>owner</strong></p>
<a class="ansibleOptionLink" href="#parameter-owner" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Name of the user that should own the filesystem object, as would be fed to <em>chown</em>.</p>
<p>When left unspecified, it uses the current user unless you are root, in which case it can preserve the previous ownership.</p>
<p>Specifying a numeric username will be assumed to be a user ID and not a username. Avoid numeric usernames to avoid this confusion.</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-path"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-path"><strong>path</strong></p>
<a class="ansibleOptionLink" href="#parameter-path" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">list</span> / <span class="ansible-option-elements">elements=path</span> / <span class="ansible-option-required">required</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Remote absolute path, glob, or list of paths or globs for the file or files to compress or archive.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-remove"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-remove"><strong>remove</strong></p>
<a class="ansibleOptionLink" href="#parameter-remove" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">boolean</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Remove any added source files and trees after adding to archive.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">false</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">true</span></code></p></li>
</ul>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-selevel"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-selevel"><strong>selevel</strong></p>
<a class="ansibleOptionLink" href="#parameter-selevel" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The level part of the SELinux filesystem object context.</p>
<p>This is the MLS/MCS attribute, sometimes known as the <code class="docutils literal notranslate"><span class="pre">range</span></code>.</p>
<p>When set to <code class="ansible-value docutils literal notranslate"><span class="pre">_default</span></code>, it will use the <code class="docutils literal notranslate"><span class="pre">level</span></code> portion of the policy if available.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-serole"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-serole"><strong>serole</strong></p>
<a class="ansibleOptionLink" href="#parameter-serole" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The role part of the SELinux filesystem object context.</p>
<p>When set to <code class="ansible-value docutils literal notranslate"><span class="pre">_default</span></code>, it will use the <code class="docutils literal notranslate"><span class="pre">role</span></code> portion of the policy if available.</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-setype"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-setype"><strong>setype</strong></p>
<a class="ansibleOptionLink" href="#parameter-setype" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The type part of the SELinux filesystem object context.</p>
<p>When set to <code class="ansible-value docutils literal notranslate"><span class="pre">_default</span></code>, it will use the <code class="docutils literal notranslate"><span class="pre">type</span></code> portion of the policy if available.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-seuser"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-seuser"><strong>seuser</strong></p>
<a class="ansibleOptionLink" href="#parameter-seuser" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The user part of the SELinux filesystem object context.</p>
<p>By default it uses the <code class="ansible-value docutils literal notranslate"><span class="pre">system</span></code> policy, where applicable.</p>
<p>When set to <code class="ansible-value docutils literal notranslate"><span class="pre">_default</span></code>, it will use the <code class="docutils literal notranslate"><span class="pre">user</span></code> portion of the policy if available.</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-unsafe_writes"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-parameter-unsafe-writes"><strong>unsafe_writes</strong></p>
<a class="ansibleOptionLink" href="#parameter-unsafe_writes" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">boolean</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Influence when to use atomic operation to prevent data corruption or inconsistent reads from the target filesystem object.</p>
<p>By default this module uses atomic operations to prevent data corruption or inconsistent reads from the target filesystem objects, but sometimes systems are configured or just broken in ways that prevent this. One example is docker mounted filesystem objects, which cannot be updated atomically from inside the container and can only be written in an unsafe manner.</p>
<p>This option allows Ansible to fall back to unsafe methods of updating filesystem objects when atomic operations fail (however, it doesn’t force Ansible to perform unsafe writes).</p>
<p>IMPORTANT! Unsafe writes are subject to race conditions and can lead to data corruption.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">false</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">true</span></code></p></li>
</ul>
</div></td>
</tr>
</tbody>
</table></div>
</section>
<section id="attributes">
<h2><a class="toc-backref" href="#id4" role="doc-backlink">Attributes</a><a class="headerlink" href="#attributes" title="Permalink to this heading"></a></h2>
<div class="wy-table-responsive"><table class="longtable ansible-option-table docutils align-default" style="width: 100%">
<thead>
<tr class="row-odd"><th class="head"><p>Attribute</p></th>
<th class="head"><p>Support</p></th>
<th class="head"><p>Description</p></th>
</tr>
</thead>
<tbody>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="attribute-check_mode"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-attribute-check-mode"><strong>check_mode</strong></p>
<a class="ansibleOptionLink" href="#attribute-check_mode" title="Permalink to this attribute"></a></div></td>
<td><div class="ansible-option-cell"><p><strong class="ansible-attribute-support-label">Support: </strong><strong class="ansible-attribute-support-full">full</strong></p>
</div></td>
<td><div class="ansible-option-cell"><p>Can run in <code class="docutils literal notranslate"><span class="pre">check_mode</span></code> and return changed status prediction without modifying target.</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="attribute-diff_mode"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-attribute-diff-mode"><strong>diff_mode</strong></p>
<a class="ansibleOptionLink" href="#attribute-diff_mode" title="Permalink to this attribute"></a></div></td>
<td><div class="ansible-option-cell"><p><strong class="ansible-attribute-support-label">Support: </strong><strong class="ansible-attribute-support-none">none</strong></p>
</div></td>
<td><div class="ansible-option-cell"><p>Will return details on what has changed (or possibly needs changing in <code class="docutils literal notranslate"><span class="pre">check_mode</span></code>), when in diff mode.</p>
</div></td>
</tr>
</tbody>
</table></div>
</section>
<section id="notes">
<h2><a class="toc-backref" href="#id5" role="doc-backlink">Notes</a><a class="headerlink" href="#notes" title="Permalink to this heading"></a></h2>
<div class="admonition note">
<p class="admonition-title">Note</p>
<ul class="simple">
<li><p>Can produce <code class="docutils literal notranslate"><span class="pre">gzip</span></code>, <code class="docutils literal notranslate"><span class="pre">bzip2</span></code>, <code class="docutils literal notranslate"><span class="pre">lzma</span></code>, and <code class="docutils literal notranslate"><span class="pre">zip</span></code> compressed files or archives.</p></li>
<li><p>This module uses <code class="docutils literal notranslate"><span class="pre">tarfile</span></code>, <code class="docutils literal notranslate"><span class="pre">zipfile</span></code>, <code class="docutils literal notranslate"><span class="pre">gzip</span></code>, and <code class="docutils literal notranslate"><span class="pre">bz2</span></code> packages on the target host to create archives. These are part of the Python standard library for Python 2 and 3.</p></li>
</ul>
</div>
</section>
<section id="see-also">
<h2><a class="toc-backref" href="#id6" role="doc-backlink">See Also</a><a class="headerlink" href="#see-also" title="Permalink to this heading"></a></h2>
<div class="admonition seealso">
<p class="admonition-title">See also</p>
<dl class="simple">
<dt><a class="reference internal" href="../../ansible/builtin/unarchive_module.html#ansible-collections-ansible-builtin-unarchive-module"><span class="std std-ref">ansible.builtin.unarchive</span></a></dt><dd><p>Unpacks an archive after (optionally) copying it from the local machine.</p>
</dd>
</dl>
</div>
</section>
<section id="examples">
<h2><a class="toc-backref" href="#id7" role="doc-backlink">Examples</a><a class="headerlink" href="#examples" title="Permalink to this heading"></a></h2>
<div class="highlight-yaml+jinja notranslate"><div class="highlight"><pre id="codecell0"><span></span><span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Compress directory /path/to/foo/ into /path/to/foo.tgz</span>
<span class="w">  </span><span class="nt">community.general.archive</span><span class="p">:</span>
<span class="w">    </span><span class="nt">path</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/to/foo</span>
<span class="w">    </span><span class="nt">dest</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/to/foo.tgz</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Compress regular file /path/to/foo into /path/to/foo.gz and remove it</span>
<span class="w">  </span><span class="nt">community.general.archive</span><span class="p">:</span>
<span class="w">    </span><span class="nt">path</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/to/foo</span>
<span class="w">    </span><span class="nt">remove</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">true</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Create a zip archive of /path/to/foo</span>
<span class="w">  </span><span class="nt">community.general.archive</span><span class="p">:</span>
<span class="w">    </span><span class="nt">path</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/to/foo</span>
<span class="w">    </span><span class="nt">format</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">zip</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Create a bz2 archive of multiple files, rooted at /path</span>
<span class="w">  </span><span class="nt">community.general.archive</span><span class="p">:</span>
<span class="w">    </span><span class="nt">path</span><span class="p">:</span>
<span class="w">    </span><span class="p p-Indicator">-</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/to/foo</span>
<span class="w">    </span><span class="p p-Indicator">-</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/wong/foo</span>
<span class="w">    </span><span class="nt">dest</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/file.tar.bz2</span>
<span class="w">    </span><span class="nt">format</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">bz2</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Create a bz2 archive of a globbed path, while excluding specific dirnames</span>
<span class="w">  </span><span class="nt">community.general.archive</span><span class="p">:</span>
<span class="w">    </span><span class="nt">path</span><span class="p">:</span>
<span class="w">    </span><span class="p p-Indicator">-</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/to/foo/*</span>
<span class="w">    </span><span class="nt">dest</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/file.tar.bz2</span>
<span class="w">    </span><span class="nt">exclude_path</span><span class="p">:</span>
<span class="w">    </span><span class="p p-Indicator">-</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/to/foo/bar</span>
<span class="w">    </span><span class="p p-Indicator">-</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/to/foo/baz</span>
<span class="w">    </span><span class="nt">format</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">bz2</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Create a bz2 archive of a globbed path, while excluding a glob of dirnames</span>
<span class="w">  </span><span class="nt">community.general.archive</span><span class="p">:</span>
<span class="w">    </span><span class="nt">path</span><span class="p">:</span>
<span class="w">    </span><span class="p p-Indicator">-</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/to/foo/*</span>
<span class="w">    </span><span class="nt">dest</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/file.tar.bz2</span>
<span class="w">    </span><span class="nt">exclude_path</span><span class="p">:</span>
<span class="w">    </span><span class="p p-Indicator">-</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/to/foo/ba*</span>
<span class="w">    </span><span class="nt">format</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">bz2</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Use gzip to compress a single archive (i.e don't archive it first with tar)</span>
<span class="w">  </span><span class="nt">community.general.archive</span><span class="p">:</span>
<span class="w">    </span><span class="nt">path</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/to/foo/single.file</span>
<span class="w">    </span><span class="nt">dest</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/file.gz</span>
<span class="w">    </span><span class="nt">format</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">gz</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Create a tar.gz archive of a single file.</span>
<span class="w">  </span><span class="nt">community.general.archive</span><span class="p">:</span>
<span class="w">    </span><span class="nt">path</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/to/foo/single.file</span>
<span class="w">    </span><span class="nt">dest</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/path/file.tar.gz</span>
<span class="w">    </span><span class="nt">format</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">gz</span>
<span class="w">    </span><span class="nt">force_archive</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">true</span>
</pre><button class="copybtn o-tooltip--left" data-tooltip="Copy" data-clipboard-target="#codecell0">
      <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-copy" width="44" height="44" viewBox="0 0 24 24" stroke-width="1.5" stroke="#000000" fill="none" stroke-linecap="round" stroke-linejoin="round">
  <title>Copy to clipboard</title>
  <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
  <rect x="8" y="8" width="12" height="12" rx="2"></rect>
  <path d="M16 8v-2a2 2 0 0 0 -2 -2h-8a2 2 0 0 0 -2 2v8a2 2 0 0 0 2 2h2"></path>
</svg>
    </button></div>
</div>
</section>
<section id="return-values">
<h2><a class="toc-backref" href="#id8" role="doc-backlink">Return Values</a><a class="headerlink" href="#return-values" title="Permalink to this heading"></a></h2>
<p>Common return values are documented <a class="reference internal" href="../../../reference_appendices/common_return_values.html#common-return-values"><span class="std std-ref">here</span></a>, the following are the fields unique to this module:</p>
<div class="wy-table-responsive"><table class="longtable ansible-option-table docutils align-default" style="width: 100%">
<thead>
<tr class="row-odd"><th class="head"><p>Key</p></th>
<th class="head"><p>Description</p></th>
</tr>
</thead>
<tbody>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-archived"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-return-archived"><strong>archived</strong></p>
<a class="ansibleOptionLink" href="#return-archived" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">list</span> / <span class="ansible-option-elements">elements=string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Any files that were compressed or added to the archive.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> success</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-arcroot"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-return-arcroot"><strong>arcroot</strong></p>
<a class="ansibleOptionLink" href="#return-arcroot" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The archive root.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> always</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-dest_state"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-return-dest-state"><strong>dest_state</strong></p>
<a class="ansibleOptionLink" href="#return-dest_state" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
<p><em class="ansible-option-versionadded">added in community.general 3.4.0</em></p>
</div></td>
<td><div class="ansible-option-cell"><p>The state of the <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-community-general-archive-module-parameter-dest"><span class="std std-ref"><span class="pre">dest</span></span></a></strong></code> file.</p>
<p><code class="ansible-value docutils literal notranslate"><span class="pre">absent</span></code> when the file does not exist.</p>
<p><code class="ansible-value docutils literal notranslate"><span class="pre">archive</span></code> when the file is an archive.</p>
<p><code class="ansible-value docutils literal notranslate"><span class="pre">compress</span></code> when the file is compressed, but not an archive.</p>
<p><code class="ansible-value docutils literal notranslate"><span class="pre">incomplete</span></code> when the file is an archive, but some files under <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-community-general-archive-module-parameter-path"><span class="std std-ref"><span class="pre">path</span></span></a></strong></code> were not found.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> success</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-expanded_exclude_paths"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-return-expanded-exclude-paths"><strong>expanded_exclude_paths</strong></p>
<a class="ansibleOptionLink" href="#return-expanded_exclude_paths" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">list</span> / <span class="ansible-option-elements">elements=string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The list of matching exclude paths from the exclude_path argument.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> always</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-expanded_paths"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-return-expanded-paths"><strong>expanded_paths</strong></p>
<a class="ansibleOptionLink" href="#return-expanded_paths" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">list</span> / <span class="ansible-option-elements">elements=string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The list of matching paths from paths argument.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> always</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-missing"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-return-missing"><strong>missing</strong></p>
<a class="ansibleOptionLink" href="#return-missing" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">list</span> / <span class="ansible-option-elements">elements=string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Any files that were missing from the source.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> success</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-state"></div><p class="ansible-option-title" id="ansible-collections-community-general-archive-module-return-state"><strong>state</strong></p>
<a class="ansibleOptionLink" href="#return-state" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The state of the input <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-community-general-archive-module-parameter-path"><span class="std std-ref"><span class="pre">path</span></span></a></strong></code>.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> always</p>
</div></td>
</tr>
</tbody>
</table></div>
<section id="authors">
<h3>Authors<a class="headerlink" href="#authors" title="Permalink to this heading"></a></h3>
<ul class="simple">
<li><p>Ben Doherty (@bendoh)</p></li>
</ul>
</section>
<section id="collection-links">
<h3>Collection links<a class="headerlink" href="#collection-links" title="Permalink to this heading"></a></h3>
<ul class="ansible-links">
<li><span><a aria-role="button" class="ansible-link reference external" href="https://github.com/ansible-collections/community.general/issues" rel="noopener external" target="_blank">Issue Tracker</a></span></li>
<li><span><a aria-role="button" class="ansible-link reference external" href="https://github.com/ansible-collections/community.general" rel="noopener external" target="_blank">Repository (Sources)</a></span></li>
<li><span><a aria-role="button" class="ansible-link reference external" href="https://github.com/ansible-collections/community.general/issues/new?assignees=&amp;labels=&amp;template=bug_report.yml" rel="noopener external" target="_blank">Submit a bug report</a></span></li>
<li><span><a aria-role="button" class="ansible-link reference external" href="https://github.com/ansible-collections/community.general/issues/new?assignees=&amp;labels=&amp;template=feature_request.yml" rel="noopener external" target="_blank">Request a feature</a></span></li>
<li><span><a class="reference internal" href="index.html#communication-for-community-general"><span class="std std-ref">Communication</span></a></span></li>
</ul>
</section>
</section>
