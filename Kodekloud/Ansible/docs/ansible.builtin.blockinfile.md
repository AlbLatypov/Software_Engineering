# ansible.builtin.blockinfile


<h1>ansible.builtin.blockinfile module – Insert/update/remove a text block surrounded by marker lines<a class="headerlink" href="#ansible-builtin-blockinfile-module-insert-update-remove-a-text-block-surrounded-by-marker-lines" title="Permalink to this heading"></a></h1>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>This module    is part of <code class="docutils literal notranslate"><span class="pre">ansible-core</span></code> and included in all Ansible
installations. In most cases, you can use the short
module name
<code class="code docutils literal notranslate"><span class="pre">blockinfile</span></code> even without specifying the <a class="reference internal" href="../../../collections_guide/collections_using_playbooks.html#collections-keyword"><span class="std std-ref">collections keyword</span></a>.
However, we recommend you use the <a class="reference internal" href="../../../reference_appendices/glossary.html#term-Fully-Qualified-Collection-Name-FQCN"><span class="xref std std-term">Fully Qualified Collection Name (FQCN)</span></a> <code class="code docutils literal notranslate"><span class="pre">ansible.builtin.blockinfile</span></code> for easy linking to the
module    documentation and to avoid conflicting with other collections that may have
the same module name.</p>
</div>
<nav class="contents local" id="contents">
<ul class="simple">
<li><p><a class="reference internal" href="#synopsis" id="id1">Synopsis</a></p></li>
<li><p><a class="reference internal" href="#parameters" id="id2">Parameters</a></p></li>
<li><p><a class="reference internal" href="#attributes" id="id3">Attributes</a></p></li>
<li><p><a class="reference internal" href="#notes" id="id4">Notes</a></p></li>
<li><p><a class="reference internal" href="#examples" id="id5">Examples</a></p></li>
</ul>
</nav>
<section id="synopsis">
<h2><a class="toc-backref" href="#id1" role="doc-backlink">Synopsis</a><a class="headerlink" href="#synopsis" title="Permalink to this heading"></a></h2>
<ul class="simple">
<li><p>This module will insert/update/remove a block of multi-line text surrounded by customizable marker lines.</p></li>
</ul>
</section>
<section id="parameters">
<h2><a class="toc-backref" href="#id2" role="doc-backlink">Parameters</a><a class="headerlink" href="#parameters" title="Permalink to this heading"></a></h2>
<div class="wy-table-responsive"><table class="longtable ansible-option-table docutils align-default" style="width: 100%">
<thead>
<tr class="row-odd"><th class="head"><p>Parameter</p></th>
<th class="head"><p>Comments</p></th>
</tr>
</thead>
<tbody>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-append_newline"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-append-newline"><strong>append_newline</strong></p>
<a class="ansibleOptionLink" href="#parameter-append_newline" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">boolean</span></p>
<p><em class="ansible-option-versionadded">added in ansible-core 2.16</em></p>
</div></td>
<td><div class="ansible-option-cell"><p>Append a blank line to the inserted block, if this does not appear at the end of the file.</p>
<p>Note that this attribute is not considered when <code class="docutils literal notranslate"><span class="pre">state</span></code> is set to <code class="docutils literal notranslate"><span class="pre">absent</span></code></p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">false</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">true</span></code></p></li>
</ul>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-attributes"></div>
<div class="ansibleOptionAnchor" id="parameter-attr"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-attributes"><span id="ansible-collections-ansible-builtin-blockinfile-module-parameter-attr"></span><strong>attributes</strong></p>
<a class="ansibleOptionLink" href="#parameter-attributes" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-aliases">aliases: attr</span></p>
<p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The attributes the resulting filesystem object should have.</p>
<p>To get supported flags look at the man page for <em>chattr</em> on the target system.</p>
<p>This string should contain the attributes in the same order as the one displayed by <em>lsattr</em>.</p>
<p>The <code class="docutils literal notranslate"><span class="pre">=</span></code> operator is assumed as default, otherwise <code class="docutils literal notranslate"><span class="pre">+</span></code> or <code class="docutils literal notranslate"><span class="pre">-</span></code> operators need to be included in the string.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-backup"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-backup"><strong>backup</strong></p>
<a class="ansibleOptionLink" href="#parameter-backup" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">boolean</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Create a backup file including the timestamp information so you can get the original file back if you somehow clobbered it incorrectly.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">false</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">true</span></code></p></li>
</ul>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-block"></div>
<div class="ansibleOptionAnchor" id="parameter-content"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-content"><span id="ansible-collections-ansible-builtin-blockinfile-module-parameter-block"></span><strong>block</strong></p>
<a class="ansibleOptionLink" href="#parameter-block" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-aliases">aliases: content</span></p>
<p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The text to insert inside the marker lines.</p>
<p>If it is missing or an empty string, the block will be removed as if <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-state"><span class="std std-ref"><span class="pre">state</span></span></a></strong></code> were specified to <code class="ansible-value docutils literal notranslate"><span class="pre">absent</span></code>.</p>
<p class="ansible-option-line"><strong class="ansible-option-default-bold">Default:</strong> <code class="ansible-option-default docutils literal notranslate"><span class="pre">""</span></code></p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-create"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-create"><strong>create</strong></p>
<a class="ansibleOptionLink" href="#parameter-create" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">boolean</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Create a new file if it does not exist.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">false</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">true</span></code></p></li>
</ul>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-group"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-group"><strong>group</strong></p>
<a class="ansibleOptionLink" href="#parameter-group" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Name of the group that should own the filesystem object, as would be fed to <em>chown</em>.</p>
<p>When left unspecified, it uses the current group of the current user unless you are root, in which case it can preserve the previous ownership.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-insertafter"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-insertafter"><strong>insertafter</strong></p>
<a class="ansibleOptionLink" href="#parameter-insertafter" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>If specified and no begin/ending <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-marker"><span class="std std-ref"><span class="pre">marker</span></span></a></strong></code> lines are found, the block will be inserted after the last match of specified regular expression.</p>
<p>A special value is available; <code class="ansible-value docutils literal notranslate"><span class="pre">EOF</span></code> for inserting the block at the end of the file.</p>
<p>If specified regular expression has no matches, <code class="ansible-value docutils literal notranslate"><span class="pre">EOF</span></code> will be used instead.</p>
<p>The presence of the multiline flag (?m) in the regular expression controls whether the match is done line by line or with multiple lines. This behaviour was added in ansible-core 2.14.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">"EOF"</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">"*regex*"</span></code></p></li>
</ul>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-insertbefore"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-insertbefore"><strong>insertbefore</strong></p>
<a class="ansibleOptionLink" href="#parameter-insertbefore" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>If specified and no begin/ending <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-marker"><span class="std std-ref"><span class="pre">marker</span></span></a></strong></code> lines are found, the block will be inserted before the last match of specified regular expression.</p>
<p>A special value is available; <code class="ansible-value docutils literal notranslate"><span class="pre">BOF</span></code> for inserting the block at the beginning of the file.</p>
<p>If specified regular expression has no matches, the block will be inserted at the end of the file.</p>
<p>The presence of the multiline flag (?m) in the regular expression controls whether the match is done line by line or with multiple lines. This behaviour was added in ansible-core 2.14.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">"BOF"</span></code></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">"*regex*"</span></code></p></li>
</ul>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-marker"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-marker"><strong>marker</strong></p>
<a class="ansibleOptionLink" href="#parameter-marker" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The marker line template.</p>
<p><code class="docutils literal notranslate"><span class="pre">{mark}</span></code> will be replaced with the values in <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-marker-begin"><span class="std std-ref"><span class="pre">marker_begin</span></span></a></strong></code> (default=”BEGIN”) and <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-marker-end"><span class="std std-ref"><span class="pre">marker_end</span></span></a></strong></code> (default=”END”).</p>
<p>Using a custom marker without the <code class="docutils literal notranslate"><span class="pre">{mark}</span></code> variable may result in the block being repeatedly inserted on subsequent playbook runs.</p>
<p>Multi-line markers are not supported and will result in the block being repeatedly inserted on subsequent playbook runs.</p>
<p>A newline is automatically appended by the module to <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-marker-begin"><span class="std std-ref"><span class="pre">marker_begin</span></span></a></strong></code> and <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-marker-end"><span class="std std-ref"><span class="pre">marker_end</span></span></a></strong></code>.</p>
<p class="ansible-option-line"><strong class="ansible-option-default-bold">Default:</strong> <code class="ansible-option-default docutils literal notranslate"><span class="pre">"#</span> <span class="pre">{mark}</span> <span class="pre">ANSIBLE</span> <span class="pre">MANAGED</span> <span class="pre">BLOCK"</span></code></p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-marker_begin"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-marker-begin"><strong>marker_begin</strong></p>
<a class="ansibleOptionLink" href="#parameter-marker_begin" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>This will be inserted at <code class="docutils literal notranslate"><span class="pre">{mark}</span></code> in the opening ansible block <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-marker"><span class="std std-ref"><span class="pre">marker</span></span></a></strong></code>.</p>
<p class="ansible-option-line"><strong class="ansible-option-default-bold">Default:</strong> <code class="ansible-option-default docutils literal notranslate"><span class="pre">"BEGIN"</span></code></p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-marker_end"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-marker-end"><strong>marker_end</strong></p>
<a class="ansibleOptionLink" href="#parameter-marker_end" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>This will be inserted at <code class="docutils literal notranslate"><span class="pre">{mark}</span></code> in the closing ansible block <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-marker"><span class="std std-ref"><span class="pre">marker</span></span></a></strong></code>.</p>
<p class="ansible-option-line"><strong class="ansible-option-default-bold">Default:</strong> <code class="ansible-option-default docutils literal notranslate"><span class="pre">"END"</span></code></p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-mode"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-mode"><strong>mode</strong></p>
<a class="ansibleOptionLink" href="#parameter-mode" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">any</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The permissions the resulting filesystem object should have.</p>
<p>For those used to <em>/usr/bin/chmod</em> remember that modes are actually octal numbers. You must give Ansible enough information to parse them correctly. For consistent results, quote octal numbers (for example, <code class="ansible-value docutils literal notranslate"><span class="pre">'644'</span></code> or <code class="ansible-value docutils literal notranslate"><span class="pre">'1777'</span></code>) so Ansible receives a string and can do its own conversion from string into number. Adding a leading zero (for example, <code class="ansible-value docutils literal notranslate"><span class="pre">0755</span></code>) works sometimes, but can fail in loops and some other circumstances.</p>
<p>Giving Ansible a number without following either of these rules will end up with a decimal number which will have unexpected results.</p>
<p>As of Ansible 1.8, the mode may be specified as a symbolic mode (for example, <code class="ansible-value docutils literal notranslate"><span class="pre">u+rwx</span></code> or <code class="ansible-value docutils literal notranslate"><span class="pre">u=rw,g=r,o=r</span></code>).</p>
<p>If <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-mode"><span class="std std-ref"><span class="pre">mode</span></span></a></strong></code> is not specified and the destination filesystem object <strong>does not</strong> exist, the default <code class="docutils literal notranslate"><span class="pre">umask</span></code> on the system will be used when setting the mode for the newly created filesystem object.</p>
<p>If <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-mode"><span class="std std-ref"><span class="pre">mode</span></span></a></strong></code> is not specified and the destination filesystem object <strong>does</strong> exist, the mode of the existing filesystem object will be used.</p>
<p>Specifying <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-mode"><span class="std std-ref"><span class="pre">mode</span></span></a></strong></code> is the best way to ensure filesystem objects are created with the correct permissions. See CVE-2020-1736 for further details.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-owner"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-owner"><strong>owner</strong></p>
<a class="ansibleOptionLink" href="#parameter-owner" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Name of the user that should own the filesystem object, as would be fed to <em>chown</em>.</p>
<p>When left unspecified, it uses the current user unless you are root, in which case it can preserve the previous ownership.</p>
<p>Specifying a numeric username will be assumed to be a user ID and not a username. Avoid numeric usernames to avoid this confusion.</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-path"></div>
<div class="ansibleOptionAnchor" id="parameter-dest"></div>
<div class="ansibleOptionAnchor" id="parameter-destfile"></div>
<div class="ansibleOptionAnchor" id="parameter-name"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-path"><span id="ansible-collections-ansible-builtin-blockinfile-module-parameter-name"></span><span id="ansible-collections-ansible-builtin-blockinfile-module-parameter-destfile"></span><span id="ansible-collections-ansible-builtin-blockinfile-module-parameter-dest"></span><strong>path</strong></p>
<a class="ansibleOptionLink" href="#parameter-path" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-aliases">aliases: dest, destfile, name</span></p>
<p class="ansible-option-type-line"><span class="ansible-option-type">path</span> / <span class="ansible-option-required">required</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The file to modify.</p>
<p>Before Ansible 2.3 this option was only usable as <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-dest"><span class="std std-ref"><span class="pre">dest</span></span></a></strong></code>, <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-destfile"><span class="std std-ref"><span class="pre">destfile</span></span></a></strong></code> and <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-name"><span class="std std-ref"><span class="pre">name</span></span></a></strong></code>.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-prepend_newline"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-prepend-newline"><strong>prepend_newline</strong></p>
<a class="ansibleOptionLink" href="#parameter-prepend_newline" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">boolean</span></p>
<p><em class="ansible-option-versionadded">added in ansible-core 2.16</em></p>
</div></td>
<td><div class="ansible-option-cell"><p>Prepend a blank line to the inserted block, if this does not appear at the beginning of the file.</p>
<p>Note that this attribute is not considered when <code class="docutils literal notranslate"><span class="pre">state</span></code> is set to <code class="docutils literal notranslate"><span class="pre">absent</span></code></p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">false</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">true</span></code></p></li>
</ul>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-selevel"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-selevel"><strong>selevel</strong></p>
<a class="ansibleOptionLink" href="#parameter-selevel" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The level part of the SELinux filesystem object context.</p>
<p>This is the MLS/MCS attribute, sometimes known as the <code class="docutils literal notranslate"><span class="pre">range</span></code>.</p>
<p>When set to <code class="ansible-value docutils literal notranslate"><span class="pre">_default</span></code>, it will use the <code class="docutils literal notranslate"><span class="pre">level</span></code> portion of the policy if available.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-serole"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-serole"><strong>serole</strong></p>
<a class="ansibleOptionLink" href="#parameter-serole" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The role part of the SELinux filesystem object context.</p>
<p>When set to <code class="ansible-value docutils literal notranslate"><span class="pre">_default</span></code>, it will use the <code class="docutils literal notranslate"><span class="pre">role</span></code> portion of the policy if available.</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-setype"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-setype"><strong>setype</strong></p>
<a class="ansibleOptionLink" href="#parameter-setype" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The type part of the SELinux filesystem object context.</p>
<p>When set to <code class="ansible-value docutils literal notranslate"><span class="pre">_default</span></code>, it will use the <code class="docutils literal notranslate"><span class="pre">type</span></code> portion of the policy if available.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-seuser"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-seuser"><strong>seuser</strong></p>
<a class="ansibleOptionLink" href="#parameter-seuser" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The user part of the SELinux filesystem object context.</p>
<p>By default it uses the <code class="ansible-value docutils literal notranslate"><span class="pre">system</span></code> policy, where applicable.</p>
<p>When set to <code class="ansible-value docutils literal notranslate"><span class="pre">_default</span></code>, it will use the <code class="docutils literal notranslate"><span class="pre">user</span></code> portion of the policy if available.</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-state"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-state"><strong>state</strong></p>
<a class="ansibleOptionLink" href="#parameter-state" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Whether the block should be there or not.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">"absent"</span></code></p></li>
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">"present"</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
</ul>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-unsafe_writes"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-unsafe-writes"><strong>unsafe_writes</strong></p>
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
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-validate"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-parameter-validate"><strong>validate</strong></p>
<a class="ansibleOptionLink" href="#parameter-validate" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The validation command to run before copying the updated file into the final destination.</p>
<p>A temporary file path is used to validate, passed in through ‘%s’ which must be present as in the examples below.</p>
<p>Also, the command is passed securely so shell features such as expansion and pipes will not work.</p>
<p>For an example on how to handle more complex validation than what this option provides, see <a class="reference internal" href="../../../reference_appendices/faq.html#complex-configuration-validation"><span class="std std-ref">handling complex validation</span></a>.</p>
</div></td>
</tr>
</tbody>
</table></div>
</section>
<section id="attributes">
<h2><a class="toc-backref" href="#id3" role="doc-backlink">Attributes</a><a class="headerlink" href="#attributes" title="Permalink to this heading"></a></h2>
<div class="wy-table-responsive"><table class="longtable ansible-option-table docutils align-default" style="width: 100%">
<thead>
<tr class="row-odd"><th class="head"><p>Attribute</p></th>
<th class="head"><p>Support</p></th>
<th class="head"><p>Description</p></th>
</tr>
</thead>
<tbody>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="attribute-check_mode"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-attribute-check-mode"><strong>check_mode</strong></p>
<a class="ansibleOptionLink" href="#attribute-check_mode" title="Permalink to this attribute"></a></div></td>
<td><div class="ansible-option-cell"><p><strong class="ansible-attribute-support-label">Support: </strong><strong class="ansible-attribute-support-full">full</strong></p>
</div></td>
<td><div class="ansible-option-cell"><p>Can run in check_mode and return changed status prediction without modifying target</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="attribute-diff_mode"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-attribute-diff-mode"><strong>diff_mode</strong></p>
<a class="ansibleOptionLink" href="#attribute-diff_mode" title="Permalink to this attribute"></a></div></td>
<td><div class="ansible-option-cell"><p><strong class="ansible-attribute-support-label">Support: </strong><strong class="ansible-attribute-support-full">full</strong></p>
</div></td>
<td><div class="ansible-option-cell"><p>Will return details on what has changed (or possibly needs changing in check_mode), when in diff mode</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="attribute-platform"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-attribute-platform"><strong>platform</strong></p>
<a class="ansibleOptionLink" href="#attribute-platform" title="Permalink to this attribute"></a></div></td>
<td><div class="ansible-option-cell"><p><strong class="ansible-attribute-support-property">Platform:</strong>&nbsp;<strong class="ansible-attribute-support-full">posix</strong></p>
</div></td>
<td><div class="ansible-option-cell"><p>Target OS/families that can be operated against</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="attribute-safe_file_operations"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-attribute-safe-file-operations"><strong>safe_file_operations</strong></p>
<a class="ansibleOptionLink" href="#attribute-safe_file_operations" title="Permalink to this attribute"></a></div></td>
<td><div class="ansible-option-cell"><p><strong class="ansible-attribute-support-label">Support: </strong><strong class="ansible-attribute-support-full">full</strong></p>
</div></td>
<td><div class="ansible-option-cell"><p>Uses Ansible’s strict file operation functions to ensure proper permissions and avoid data corruption</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="attribute-vault"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-blockinfile-module-attribute-vault"><strong>vault</strong></p>
<a class="ansibleOptionLink" href="#attribute-vault" title="Permalink to this attribute"></a></div></td>
<td><div class="ansible-option-cell"><p><strong class="ansible-attribute-support-label">Support: </strong><strong class="ansible-attribute-support-none">none</strong></p>
</div></td>
<td><div class="ansible-option-cell"><p>Can automatically decrypt Ansible vaulted files</p>
</div></td>
</tr>
</tbody>
</table></div>
</section>
<section id="notes">
<h2><a class="toc-backref" href="#id4" role="doc-backlink">Notes</a><a class="headerlink" href="#notes" title="Permalink to this heading"></a></h2>
<div class="admonition note">
<p class="admonition-title">Note</p>
<ul class="simple">
<li><p>When using ‘with_*’ loops be aware that if you do not set a unique mark the block will be overwritten on each iteration.</p></li>
<li><p>As of Ansible 2.3, the <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-dest"><span class="std std-ref"><span class="pre">dest</span></span></a></strong></code> option has been changed to <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-path"><span class="std std-ref"><span class="pre">path</span></span></a></strong></code> as default, but <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-dest"><span class="std std-ref"><span class="pre">dest</span></span></a></strong></code> still works as well.</p></li>
<li><p>Option <code class="ansible-option docutils literal notranslate"><strong><span><span class="pre">follow</span></span></strong></code> has been removed in Ansible 2.5, because this module modifies the contents of the file so <code class="ansible-option-value docutils literal notranslate"><span><span class="pre">follow=no</span></span></code> does not make sense.</p></li>
<li><p>When more then one block should be handled in one file you must change the <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-blockinfile-module-parameter-marker"><span class="std std-ref"><span class="pre">marker</span></span></a></strong></code> per task.</p></li>
</ul>
</div>
</section>
<section id="examples">
<h2><a class="toc-backref" href="#id5" role="doc-backlink">Examples</a><a class="headerlink" href="#examples" title="Permalink to this heading"></a></h2>
<div class="highlight-yaml+jinja notranslate"><div class="highlight"><pre id="codecell0"><span></span><span class="c1"># Before Ansible 2.3, option 'dest' or 'name' was used instead of 'path'</span>
<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Insert/Update "Match User" configuration block in /etc/ssh/sshd_config prepending and appending a new line</span>
<span class="w">  </span><span class="nt">ansible.builtin.blockinfile</span><span class="p">:</span>
<span class="w">    </span><span class="nt">path</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/etc/ssh/sshd_config</span>
<span class="w">    </span><span class="nt">append_newline</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">true</span>
<span class="w">    </span><span class="nt">prepend_newline</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">true</span>
<span class="w">    </span><span class="nt">block</span><span class="p">:</span><span class="w"> </span><span class="p p-Indicator">|</span>
<span class="w">      </span><span class="no">Match User ansible-agent</span>
<span class="w">      </span><span class="no">PasswordAuthentication no</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Insert/Update eth0 configuration stanza in /etc/network/interfaces</span>
<span class="w">        </span><span class="l l-Scalar l-Scalar-Plain">(it might be better to copy files into /etc/network/interfaces.d/)</span>
<span class="w">  </span><span class="nt">ansible.builtin.blockinfile</span><span class="p">:</span>
<span class="w">    </span><span class="nt">path</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/etc/network/interfaces</span>
<span class="w">    </span><span class="nt">block</span><span class="p">:</span><span class="w"> </span><span class="p p-Indicator">|</span>
<span class="w">      </span><span class="no">iface eth0 inet static</span>
<span class="w">          </span><span class="no">address 192.0.2.23</span>
<span class="w">          </span><span class="no">netmask 255.255.255.0</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Insert/Update configuration using a local file and validate it</span>
<span class="w">  </span><span class="nt">ansible.builtin.blockinfile</span><span class="p">:</span>
<span class="w">    </span><span class="nt">block</span><span class="p">:</span><span class="w"> </span><span class="s">"</span><span class="cp">{{</span> <span class="nv">lookup</span><span class="o">(</span><span class="s1">'ansible.builtin.file'</span><span class="o">,</span> <span class="s1">'./local/sshd_config'</span><span class="o">)</span> <span class="cp">}}</span><span class="s">"</span>
<span class="w">    </span><span class="nt">path</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/etc/ssh/sshd_config</span>
<span class="w">    </span><span class="nt">backup</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">yes</span>
<span class="w">    </span><span class="nt">validate</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/usr/sbin/sshd -T -f %s</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Insert/Update HTML surrounded by custom markers after &lt;body&gt; line</span>
<span class="w">  </span><span class="nt">ansible.builtin.blockinfile</span><span class="p">:</span>
<span class="w">    </span><span class="nt">path</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/var/www/html/index.html</span>
<span class="w">    </span><span class="nt">marker</span><span class="p">:</span><span class="w"> </span><span class="s">"&lt;!--</span><span class="nv"> </span><span class="s">{mark}</span><span class="nv"> </span><span class="s">ANSIBLE</span><span class="nv"> </span><span class="s">MANAGED</span><span class="nv"> </span><span class="s">BLOCK</span><span class="nv"> </span><span class="s">--&gt;"</span>
<span class="w">    </span><span class="nt">insertafter</span><span class="p">:</span><span class="w"> </span><span class="s">"&lt;body&gt;"</span>
<span class="w">    </span><span class="nt">block</span><span class="p">:</span><span class="w"> </span><span class="p p-Indicator">|</span>
<span class="w">      </span><span class="no">&lt;h1&gt;Welcome to </span><span class="cp">{{</span> <span class="nv">ansible_hostname</span> <span class="cp">}}</span><span class="no">&lt;/h1&gt;</span>
<span class="w">      </span><span class="no">&lt;p&gt;Last updated on </span><span class="cp">{{</span> <span class="nv">ansible_date_time.iso8601</span> <span class="cp">}}</span><span class="no">&lt;/p&gt;</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Remove HTML as well as surrounding markers</span>
<span class="w">  </span><span class="nt">ansible.builtin.blockinfile</span><span class="p">:</span>
<span class="w">    </span><span class="nt">path</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/var/www/html/index.html</span>
<span class="w">    </span><span class="nt">marker</span><span class="p">:</span><span class="w"> </span><span class="s">"&lt;!--</span><span class="nv"> </span><span class="s">{mark}</span><span class="nv"> </span><span class="s">ANSIBLE</span><span class="nv"> </span><span class="s">MANAGED</span><span class="nv"> </span><span class="s">BLOCK</span><span class="nv"> </span><span class="s">--&gt;"</span>
<span class="w">    </span><span class="nt">block</span><span class="p">:</span><span class="w"> </span><span class="s">""</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Add mappings to /etc/hosts</span>
<span class="w">  </span><span class="nt">ansible.builtin.blockinfile</span><span class="p">:</span>
<span class="w">    </span><span class="nt">path</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/etc/hosts</span>
<span class="w">    </span><span class="nt">block</span><span class="p">:</span><span class="w"> </span><span class="p p-Indicator">|</span>
<span class="w">      </span><span class="cp">{{</span> <span class="nv">item.ip</span> <span class="cp">}}</span><span class="w"> </span><span class="cp">{{</span> <span class="nv">item.name</span> <span class="cp">}}</span>
<span class="w">    </span><span class="nt">marker</span><span class="p">:</span><span class="w"> </span><span class="s">"#</span><span class="nv"> </span><span class="s">{mark}</span><span class="nv"> </span><span class="s">ANSIBLE</span><span class="nv"> </span><span class="s">MANAGED</span><span class="nv"> </span><span class="s">BLOCK</span><span class="nv"> </span><span class="cp">{{</span> <span class="nv">item.name</span> <span class="cp">}}</span><span class="s">"</span>
<span class="w">  </span><span class="nt">loop</span><span class="p">:</span>
<span class="w">    </span><span class="p p-Indicator">-</span><span class="w"> </span><span class="p p-Indicator">{</span><span class="nt"> name</span><span class="p">:</span><span class="w"> </span><span class="nv">host1</span><span class="p p-Indicator">,</span><span class="nt"> ip</span><span class="p">:</span><span class="w"> </span><span class="nv">10.10.1.10</span><span class="w"> </span><span class="p p-Indicator">}</span>
<span class="w">    </span><span class="p p-Indicator">-</span><span class="w"> </span><span class="p p-Indicator">{</span><span class="nt"> name</span><span class="p">:</span><span class="w"> </span><span class="nv">host2</span><span class="p p-Indicator">,</span><span class="nt"> ip</span><span class="p">:</span><span class="w"> </span><span class="nv">10.10.1.11</span><span class="w"> </span><span class="p p-Indicator">}</span>
<span class="w">    </span><span class="p p-Indicator">-</span><span class="w"> </span><span class="p p-Indicator">{</span><span class="nt"> name</span><span class="p">:</span><span class="w"> </span><span class="nv">host3</span><span class="p p-Indicator">,</span><span class="nt"> ip</span><span class="p">:</span><span class="w"> </span><span class="nv">10.10.1.12</span><span class="w"> </span><span class="p p-Indicator">}</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Search with a multiline search flags regex and if found insert after</span>
<span class="w">  </span><span class="nt">blockinfile</span><span class="p">:</span>
<span class="w">    </span><span class="nt">path</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">listener.ora</span>
<span class="w">    </span><span class="nt">block</span><span class="p">:</span><span class="w"> </span><span class="s">"</span><span class="cp">{{</span> <span class="nv">listener_line</span> <span class="o">|</span> <span class="nf">indent</span><span class="o">(</span><span class="nv">width</span><span class="o">=</span><span class="m">8</span><span class="o">,</span> <span class="nv">first</span><span class="o">=</span><span class="kp">True</span><span class="o">)</span> <span class="cp">}}</span><span class="s">"</span>
<span class="w">    </span><span class="nt">insertafter</span><span class="p">:</span><span class="w"> </span><span class="s">'(?m)SID_LIST_LISTENER_DG</span><span class="nv"> </span><span class="s">=\n.*\(SID_LIST</span><span class="nv"> </span><span class="s">='</span>
<span class="w">    </span><span class="nt">marker</span><span class="p">:</span><span class="w"> </span><span class="s">"</span><span class="nv">    </span><span class="s">&lt;!--</span><span class="nv"> </span><span class="s">{mark}</span><span class="nv"> </span><span class="s">ANSIBLE</span><span class="nv"> </span><span class="s">MANAGED</span><span class="nv"> </span><span class="s">BLOCK</span><span class="nv"> </span><span class="s">--&gt;"</span>
</pre><button class="copybtn o-tooltip--left" data-tooltip="Copy" data-clipboard-target="#codecell0">
      <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-copy" width="44" height="44" viewBox="0 0 24 24" stroke-width="1.5" stroke="#000000" fill="none" stroke-linecap="round" stroke-linejoin="round">
  <title>Copy to clipboard</title>
  <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
  <rect x="8" y="8" width="12" height="12" rx="2"></rect>
  <path d="M16 8v-2a2 2 0 0 0 -2 -2h-8a2 2 0 0 0 -2 2v8a2 2 0 0 0 2 2h2"></path>
</svg>
    </button></div>
</div>
<section id="authors">
<h3>Authors<a class="headerlink" href="#authors" title="Permalink to this heading"></a></h3>
<ul class="simple">
<li><p>Yaegashi Takeshi (@yaegashi)</p></li>
</ul>
</section>
<section id="collection-links">
<h3>Collection links<a class="headerlink" href="#collection-links" title="Permalink to this heading"></a></h3>
<ul class="ansible-links">
<li><span><a aria-role="button" class="ansible-link reference external" href="https://github.com/ansible/ansible/issues" rel="noopener external" target="_blank">Issue Tracker</a></span></li>
<li><span><a aria-role="button" class="ansible-link reference external" href="https://github.com/ansible/ansible" rel="noopener external" target="_blank">Repository (Sources)</a></span></li>
<li><span><a class="reference internal" href="index.html#communication-for-ansible-builtin"><span class="std std-ref">Communication</span></a></span></li>
</ul>
</section>
</section>
